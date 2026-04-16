from __future__ import annotations

import json
import re
from collections import Counter, defaultdict
from pathlib import Path
from typing import Iterable

from graphify.analyze import god_nodes, suggest_questions, surprising_connections
from graphify.build import build_from_json
from graphify.cluster import cluster, score_all
from graphify.export import to_html, to_json
from graphify.report import generate


ROOT = Path(__file__).resolve().parents[1]
OUT_DIR = ROOT / "graphify-out" / "curated"


SYSTEMS: dict[str, dict[str, object]] = {
    "gsd_workflow": {
        "label": "Lean GSD Workflow",
        "keywords": [
            "gsd",
            ".planning",
            "phase 1",
            "roadmap",
            "requirements",
            "state.md",
            "plan.md",
        ],
    },
    "app_shell": {
        "label": "App Shell",
        "keywords": [
            "home screen",
            "start run",
            "material 3",
            "portrait",
            "app shell",
            "battle shell",
        ],
    },
    "battle_logic": {
        "label": "Battle Logic",
        "keywords": [
            "turn resolver",
            "turn resolution",
            "attack",
            "block",
            "heal",
            "shield",
            "dice",
            "resolve turn",
        ],
    },
    "enemy_generation": {
        "label": "Enemy Generation",
        "keywords": [
            "enemy factory",
            "enemy archetype",
            "enemy lineup",
            "battle scaling",
            "striker",
            "brute",
            "trickster",
        ],
    },
    "run_flow": {
        "label": "Run Flow",
        "keywords": [
            "10-battle run",
            "run flow",
            "victory",
            "game over",
            "battles cleared",
            "battle 10",
        ],
    },
    "rewards": {
        "label": "Rewards",
        "keywords": [
            "reward",
            "sharp edge",
            "iron skin",
            "field medicine",
            "vitality",
        ],
    },
    "persistence": {
        "label": "Persistence",
        "keywords": [
            "shared_preferences",
            "best_streak",
            "tutorial_seen",
            "persistence",
        ],
    },
    "quality_gates": {
        "label": "Quality Gates",
        "keywords": [
            "flutter analyze",
            "flutter test",
            "qa checklist",
            "unit tests",
            "widget tests",
            "quality gates",
        ],
    },
    "second_brain": {
        "label": "Second Brain Sync",
        "keywords": [
            "obsidian",
            "graphify",
            "2nd brain",
            "second brain",
            "vault",
        ],
    },
}


PHASES = {
    "phase_1": "Project shell and rule engine",
    "phase_2": "Battle screen",
    "phase_3": "Run flow and rewards",
    "phase_4": "Persistence and polish",
    "phase_5": "Stabilization",
}


def slugify(value: str) -> str:
    return re.sub(r"[^a-z0-9]+", "_", value.lower()).strip("_")


class ExtractionBuilder:
    def __init__(self) -> None:
        self.nodes: dict[str, dict[str, object]] = {}
        self.edges: list[dict[str, object]] = []

    def add_node(self, node_id: str, label: str, file_type: str, source_file: str) -> None:
        if node_id in self.nodes:
            return
        self.nodes[node_id] = {
            "id": node_id,
            "label": label,
            "file_type": file_type,
            "source_file": source_file,
            "source_location": None,
            "source_url": None,
            "captured_at": None,
            "author": None,
            "contributor": "Codex",
        }

    def add_edge(
        self,
        source: str,
        target: str,
        relation: str,
        confidence: str,
        source_file: str,
        confidence_score: float,
    ) -> None:
        self.edges.append(
            {
                "source": source,
                "target": target,
                "relation": relation,
                "confidence": confidence,
                "confidence_score": confidence_score,
                "source_file": source_file,
                "source_location": None,
                "weight": 1.0,
            }
        )


def parse_dart_symbols(text: str) -> tuple[list[str], list[str], list[str]]:
    imports = re.findall(r"^\s*import\s+'([^']+)';", text, flags=re.MULTILINE)
    classes = re.findall(r"\bclass\s+(\w+)", text)
    functions = re.findall(
        r"\b(?:Future<[^>]+>|Future<void>|void|int|double|String|ThemeData|TurnOutcome|EnemyState|RunState|Widget|ThemeData)\s+(\w+)\s*\(",
        text,
    )
    return imports, classes, functions


def project_files() -> list[Path]:
    files: list[Path] = []
    for path in ROOT.rglob("*"):
        if not path.is_file():
            continue
        if "graphify-out" in path.parts or path.parts[-1] == "__pycache__":
            continue
        if path.suffix not in {".md", ".dart", ".yaml"} and path.name != "pubspec.yaml":
            continue
        files.append(path)
    return sorted(files)


def classify_file(path: Path) -> str:
    if path.suffix == ".dart":
        return "code"
    return "document"


def infer_systems(text: str, rel_path: str) -> set[str]:
    lower_text = text.lower()
    hits: set[str] = set()

    for system_id, config in SYSTEMS.items():
        keywords = config["keywords"]
        if any(keyword in lower_text for keyword in keywords):  # type: ignore[arg-type]
            hits.add(system_id)

    path_map = {
        "app/lib/app/": "app_shell",
        "app/lib/features/home/": "app_shell",
        "app/lib/features/battle/turn_resolver.dart": "battle_logic",
        "app/lib/features/battle/battle_models.dart": "battle_logic",
        "app/lib/features/battle/enemy_factory.dart": "enemy_generation",
        "app/lib/features/battle/battle_screen.dart": "app_shell",
        "app/lib/features/rewards/": "rewards",
        "app/lib/features/run/": "run_flow",
        "app/test/": "quality_gates",
        ".planning/": "gsd_workflow",
    }
    for prefix, system_id in path_map.items():
        if rel_path.startswith(prefix):
            hits.add(system_id)

    return hits


def import_target(import_path: str, current_path: str, known_file_nodes: dict[str, str]) -> str | None:
    if import_path.startswith("package:dice_battler/"):
        rel = import_path.replace("package:dice_battler/", "")
        candidate = f"app/lib/{rel}"
        return known_file_nodes.get(candidate)

    if import_path.startswith("../") or import_path.startswith("./"):
        parent = Path(current_path).parent
        candidate = (parent / import_path).resolve().relative_to(ROOT).as_posix()
        return known_file_nodes.get(candidate)

    return None


def build_curated_extraction() -> dict[str, object]:
    builder = ExtractionBuilder()
    files = project_files()
    known_file_nodes: dict[str, str] = {}
    system_to_files: defaultdict[str, list[str]] = defaultdict(list)

    for system_id, config in SYSTEMS.items():
        builder.add_node(system_id, str(config["label"]), "document", "project")

    for phase_id, label in PHASES.items():
        builder.add_node(phase_id, f"{phase_id.replace('_', ' ').title()}: {label}", "document", ".planning/ROADMAP.md")

    for path in files:
        rel = path.relative_to(ROOT).as_posix()
        file_node = f"file::{slugify(rel)}"
        known_file_nodes[rel] = file_node
        builder.add_node(file_node, path.name, classify_file(path), rel)

    for path in files:
        rel = path.relative_to(ROOT).as_posix()
        file_node = known_file_nodes[rel]
        text = path.read_text(encoding="utf-8", errors="ignore")
        file_type = classify_file(path)

        for system_id in infer_systems(text, rel):
            builder.add_edge(file_node, system_id, "references", "EXTRACTED", rel, 1.0)
            system_to_files[system_id].append(file_node)

        if file_type == "document":
            if rel.endswith("PRD.md"):
                for system_id in ["app_shell", "battle_logic", "enemy_generation", "run_flow", "rewards", "quality_gates"]:
                    builder.add_edge(file_node, system_id, "rationale_for", "EXTRACTED", rel, 1.0)
            if rel.endswith("TECHNICAL_DESIGN.md"):
                for system_id in ["gsd_workflow", "app_shell", "battle_logic", "enemy_generation", "persistence", "quality_gates"]:
                    builder.add_edge(file_node, system_id, "rationale_for", "EXTRACTED", rel, 1.0)
            if rel.endswith("IMPLEMENTATION_PLAN.md"):
                builder.add_edge(file_node, "phase_1", "defines", "EXTRACTED", rel, 1.0)
                builder.add_edge(file_node, "phase_2", "defines", "EXTRACTED", rel, 1.0)
                builder.add_edge(file_node, "phase_3", "defines", "EXTRACTED", rel, 1.0)
                builder.add_edge(file_node, "phase_4", "defines", "EXTRACTED", rel, 1.0)
                builder.add_edge(file_node, "phase_5", "defines", "EXTRACTED", rel, 1.0)
            if rel.endswith("QA_CHECKLIST.md"):
                builder.add_edge(file_node, "quality_gates", "rationale_for", "EXTRACTED", rel, 1.0)
            if rel.endswith(".planning/ROADMAP.md"):
                for phase_id in PHASES:
                    builder.add_edge(file_node, phase_id, "contains", "EXTRACTED", rel, 1.0)

        if file_type == "code":
            imports, classes, functions = parse_dart_symbols(text)

            for class_name in classes:
                symbol_node = f"symbol::{slugify(rel)}::{slugify(class_name)}"
                builder.add_node(symbol_node, class_name, "code", rel)
                builder.add_edge(file_node, symbol_node, "contains", "EXTRACTED", rel, 1.0)

            for function_name in functions:
                symbol_node = f"symbol::{slugify(rel)}::{slugify(function_name)}"
                builder.add_node(symbol_node, f"{function_name}()", "code", rel)
                builder.add_edge(file_node, symbol_node, "contains", "EXTRACTED", rel, 1.0)

            for import_path in imports:
                target = import_target(import_path, rel, known_file_nodes)
                if target:
                    builder.add_edge(file_node, target, "imports", "EXTRACTED", rel, 1.0)
                else:
                    import_node = f"import::{slugify(import_path)}"
                    builder.add_node(import_node, import_path, "code", rel)
                    builder.add_edge(file_node, import_node, "imports", "EXTRACTED", rel, 1.0)

            if rel.startswith("app/test/"):
                imported_local_files = [import_target(import_path, rel, known_file_nodes) for import_path in imports]
                for target in imported_local_files:
                    if target:
                        builder.add_edge(file_node, target, "verifies", "INFERRED", rel, 0.9)

    phase_to_systems = {
        "phase_1": ["gsd_workflow", "app_shell", "battle_logic", "enemy_generation", "quality_gates"],
        "phase_2": ["app_shell", "battle_logic", "enemy_generation"],
        "phase_3": ["run_flow", "rewards"],
        "phase_4": ["persistence", "quality_gates"],
        "phase_5": ["quality_gates"],
    }
    for phase_id, systems in phase_to_systems.items():
        for system_id in systems:
            builder.add_edge(phase_id, system_id, "addresses", "EXTRACTED", ".planning/ROADMAP.md", 1.0)

    builder.add_edge("phase_2", "phase_1", "depends_on", "EXTRACTED", ".planning/ROADMAP.md", 1.0)
    builder.add_edge("phase_3", "phase_2", "depends_on", "EXTRACTED", ".planning/ROADMAP.md", 1.0)
    builder.add_edge("phase_4", "phase_3", "depends_on", "EXTRACTED", ".planning/ROADMAP.md", 1.0)
    builder.add_edge("phase_5", "phase_4", "depends_on", "EXTRACTED", ".planning/ROADMAP.md", 1.0)

    builder.add_edge("second_brain", "gsd_workflow", "conceptually_related_to", "INFERRED", "manual", 0.8)
    builder.add_edge("second_brain", "quality_gates", "conceptually_related_to", "INFERRED", "manual", 0.7)
    builder.add_edge("run_flow", "rewards", "conceptually_related_to", "INFERRED", "manual", 0.85)
    builder.add_edge("battle_logic", "enemy_generation", "shares_data_with", "INFERRED", "manual", 0.9)
    builder.add_edge("app_shell", "battle_logic", "shares_data_with", "INFERRED", "manual", 0.75)

    hyperedges = [
        {
            "id": "phase_1_delivery",
            "label": "Phase 1 Delivery",
            "nodes": ["phase_1", "app_shell", "battle_logic", "enemy_generation", "quality_gates"],
            "relation": "participate_in",
            "confidence": "EXTRACTED",
            "confidence_score": 1.0,
            "source_file": ".planning/ROADMAP.md",
        },
        {
            "id": "project_brain_loop",
            "label": "Project Brain Loop",
            "nodes": ["gsd_workflow", "quality_gates", "second_brain"],
            "relation": "form",
            "confidence": "INFERRED",
            "confidence_score": 0.82,
            "source_file": "manual",
        },
    ]

    return {
        "nodes": list(builder.nodes.values()),
        "edges": builder.edges,
        "hyperedges": hyperedges,
        "input_tokens": 0,
        "output_tokens": 0,
    }


def derive_community_labels(graph, communities: dict[int, list[str]]) -> dict[int, str]:
    labels: dict[int, str] = {}
    for cid, members in communities.items():
        words: list[str] = []
        for node_id in members:
            label = str(graph.nodes[node_id].get("label", node_id))
            words.extend(re.findall(r"[A-Za-z][A-Za-z0-9]+", label))
        common = [word for word, _count in Counter(word.lower() for word in words).most_common(3)]
        labels[cid] = " / ".join(common) if common else f"Community {cid}"
    return labels


def write_outputs(extraction: dict[str, object]) -> dict[str, object]:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    graph = build_from_json(extraction, directed=True)
    communities = cluster(graph)
    cohesion = score_all(graph, communities)
    community_labels = derive_community_labels(graph, communities)

    report = generate(
        graph,
        communities,
        cohesion,
        community_labels,
        god_nodes(graph, top_n=10),
        surprising_connections(graph, communities, top_n=7),
        {
            "total_files": len(project_files()),
            "total_words": sum(
                len(path.read_text(encoding="utf-8", errors="ignore").split())
                for path in project_files()
            ),
        },
        {"input": 0, "output": 0},
        "Dice Battler Curated Graph",
        suggest_questions(graph, communities, community_labels, top_n=5),
    )

    (OUT_DIR / "curated_extraction.json").write_text(
        json.dumps(extraction, indent=2),
        encoding="utf-8",
    )
    (OUT_DIR / "CURATED_GRAPH_REPORT.md").write_text(report, encoding="utf-8")
    to_json(graph, communities, str(OUT_DIR / "curated_graph.json"))
    to_html(graph, communities, str(OUT_DIR / "curated_graph.html"), community_labels)

    summary = {
        "files": len(project_files()),
        "nodes": graph.number_of_nodes(),
        "edges": graph.number_of_edges(),
        "communities": len(communities),
        "systems": sorted(SYSTEMS.keys()),
        "phases": sorted(PHASES.keys()),
        "top_god_nodes": god_nodes(graph, top_n=10),
    }
    (OUT_DIR / "curated_sync_summary.json").write_text(
        json.dumps(summary, indent=2),
        encoding="utf-8",
    )
    return summary


def main() -> None:
    extraction = build_curated_extraction()
    summary = write_outputs(extraction)
    print(json.dumps(summary, indent=2))


if __name__ == "__main__":
    main()
