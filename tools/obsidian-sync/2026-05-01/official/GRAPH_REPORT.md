# Graph Report - .  (2026-05-01)

## Corpus Check
- 29 files · ~12,077 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 282 nodes · 324 edges · 18 communities detected
- Extraction: 98% EXTRACTED · 2% INFERRED · 0% AMBIGUOUS · INFERRED: 7 edges (avg confidence: 0.84)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Community 0|Community 0]]
- [[_COMMUNITY_Community 1|Community 1]]
- [[_COMMUNITY_Community 2|Community 2]]
- [[_COMMUNITY_Community 3|Community 3]]
- [[_COMMUNITY_Community 4|Community 4]]
- [[_COMMUNITY_Community 5|Community 5]]
- [[_COMMUNITY_Community 6|Community 6]]
- [[_COMMUNITY_Community 7|Community 7]]
- [[_COMMUNITY_Community 8|Community 8]]
- [[_COMMUNITY_Community 9|Community 9]]
- [[_COMMUNITY_Community 10|Community 10]]
- [[_COMMUNITY_Community 11|Community 11]]
- [[_COMMUNITY_Community 12|Community 12]]
- [[_COMMUNITY_Community 13|Community 13]]
- [[_COMMUNITY_Community 14|Community 14]]
- [[_COMMUNITY_Community 15|Community 15]]
- [[_COMMUNITY_Community 16|Community 16]]
- [[_COMMUNITY_Community 17|Community 17]]

## God Nodes (most connected - your core abstractions)
1. `package:flutter/material.dart` - 13 edges
2. `build_curated_extraction()` - 11 edges
3. `package:flutter_test/flutter_test.dart` - 8 edges
4. `package:dice_battler/features/battle/battle_models.dart` - 6 edges
5. `Exact MVP Rule Set` - 6 edges
6. `ExtractionBuilder` - 5 edges
7. `Milestone 1: Project shell and rule engine` - 5 edges
8. `write_outputs()` - 4 edges
9. `package:dice_battler/features/storage/save_service.dart` - 4 edges
10. `battle_models.dart` - 4 edges

## Surprising Connections (you probably didn't know these)
- `Core Design Pillars` --conceptually_related_to--> `Deterministic Game Logic via Pure Dart Functions`  [INFERRED]
  PRD.md → TECHNICAL_DESIGN.md
- `Turn Resolution Order` --conceptually_related_to--> `Deterministic Game Logic via Pure Dart Functions`  [INFERRED]
  PRD.md → TECHNICAL_DESIGN.md
- `Deterministic Enemy Lineup Table (Battles 1-10)` --conceptually_related_to--> `EnemyFactory (pure Dart enemy generation)`  [INFERRED]
  PRD.md → TECHNICAL_DESIGN.md
- `Reward Pool (Sharp Edge/Iron Skin/Field Medicine/Vitality)` --conceptually_related_to--> `RewardService (pure Dart reward application)`  [INFERRED]
  PRD.md → TECHNICAL_DESIGN.md
- `Local Save Requirements (best streak, tutorial flag)` --shares_data_with--> `Persistence Keys (best_streak, tutorial_seen)`  [INFERRED]
  PRD.md → TECHNICAL_DESIGN.md

## Hyperedges (group relationships)
- **Recommended Reading Flow** — START_HERE_doc, PRD_doc, TECHNICAL_DESIGN_doc, IMPLEMENTATION_PLAN_doc, QA_CHECKLIST_doc, CLAUDE_doc, AGENTS_doc [EXTRACTED 1.00]
- **Milestone Sequence (1-5)** — PLAN_milestone_1, PLAN_milestone_2, PLAN_milestone_3, PLAN_milestone_4, PLAN_milestone_5 [EXTRACTED 1.00]
- **Phase 1 Delivery** — PLAN_milestone_1, CONCEPT_app_shell, CONCEPT_battle_logic, CONCEPT_enemy_generation, QUALITY_GATES_flutter_analyze_test [EXTRACTED 1.00]

## Communities

### Community 0 - "Community 0"
Cohesion: 0.05
Nodes (44): Constraint: Android only, UI: Material 3, Constraint: No backend/services/network calls, Constraint: Offline only (no networking), Constraint: Placeholder art only, Actions: Attack / Block / Heal, Battle Scaling Tiers (1.0/1.25/1.5), Core Design Pillars (+36 more)

### Community 1 - "Community 1"
Cohesion: 0.07
Nodes (31): SaveService, main, main, main, BattleController, copyWithMemory, _FakeSaveService, main (+23 more)

### Community 2 - "Community 2"
Cohesion: 0.08
Nodes (24): BattleController, cycleDieAction, _nextActionFor, _resetBattle, resolveCurrentTurn, restartBattle, battleMultiplierForBattle, createEnemyForBattle (+16 more)

### Community 3 - "Community 3"
Cohesion: 0.09
Nodes (19): app/app.dart, buildAppTheme, ThemeData, build, HomeScreen, _HomeScreenState, initState, _loadBestStreak (+11 more)

### Community 4 - "Community 4"
Cohesion: 0.13
Nodes (16): Concept: App Shell, Concept: Battle Logic / Rule Engine, Concept: Enemy Generation, Milestone 1: Project shell and rule engine, Milestone 2: Battle screen, Milestone 3: Run flow and rewards, Milestone 4: Persistence and polish, Milestone 5: Bug fixing (+8 more)

### Community 5 - "Community 5"
Cohesion: 0.1
Nodes (20): _actionLabel, _backgroundColor, BattleScreen, _BattleScreenState, build, Card, Color, _CombatantCard (+12 more)

### Community 6 - "Community 6"
Cohesion: 0.11
Nodes (15): build, Icon, RewardScreen, Scaffold, SizedBox, Text, applyReward, descriptionFor (+7 more)

### Community 7 - "Community 7"
Cohesion: 0.12
Nodes (16): BattleController, _battleControllerFactory, _buildBattleController, _completeBattleDefeat, _completeBattleVictory, _defaultBattleControllerFactory, _recordBestStreak, _resetShield (+8 more)

### Community 8 - "Community 8"
Cohesion: 0.12
Nodes (16): AnimatedBuilder, BattleScreen, build, dispose, GameOverScreen, initState, RewardScreen, RunScreen (+8 more)

### Community 9 - "Community 9"
Cohesion: 0.26
Nodes (11): build_curated_extraction(), classify_file(), derive_community_labels(), ExtractionBuilder, import_target(), infer_systems(), main(), parse_dart_symbols() (+3 more)

### Community 10 - "Community 10"
Cohesion: 0.22
Nodes (8): build, DiceBattlerApp, MaterialApp, ../features/battle/battle_screen.dart, ../features/home/home_screen.dart, ../features/run/run_screen.dart, routes.dart, theme.dart

### Community 11 - "Community 11"
Cohesion: 0.29
Nodes (6): build, GameOverScreen, Scaffold, SizedBox, Spacer, Text

### Community 12 - "Community 12"
Cohesion: 0.29
Nodes (6): build, Scaffold, SizedBox, Spacer, Text, VictoryScreen

### Community 13 - "Community 13"
Cohesion: 0.33
Nodes (5): advanceIntent, copyWith, DieModel, EnemyState, PlayerState

### Community 14 - "Community 14"
Cohesion: 1.0
Nodes (1): AppRoutes

### Community 15 - "Community 15"
Cohesion: 1.0
Nodes (2): graphify-out/curated/CURATED_GRAPH_REPORT.md, Graphify Curated Graph Report Summary

### Community 16 - "Community 16"
Cohesion: 1.0
Nodes (2): Graphify Graph Report Summary, graphify-out/GRAPH_REPORT.md

### Community 17 - "Community 17"
Cohesion: 1.0
Nodes (0): 

## Knowledge Gaps
- **200 isolated node(s):** `main`, `package:dice_battler/features/battle/enemy_factory.dart`, `main`, `package:dice_battler/features/battle/turn_resolver.dart`, `main` (+195 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **Thin community `Community 14`** (2 nodes): `routes.dart`, `AppRoutes`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 15`** (2 nodes): `graphify-out/curated/CURATED_GRAPH_REPORT.md`, `Graphify Curated Graph Report Summary`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 16`** (2 nodes): `Graphify Graph Report Summary`, `graphify-out/GRAPH_REPORT.md`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 17`** (1 nodes): `reward_models.dart`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `package:flutter/material.dart` connect `Community 3` to `Community 1`, `Community 5`, `Community 6`, `Community 8`, `Community 10`, `Community 11`, `Community 12`?**
  _High betweenness centrality (0.319) - this node is a cross-community bridge._
- **Why does `battle_models.dart` connect `Community 2` to `Community 5`?**
  _High betweenness centrality (0.093) - this node is a cross-community bridge._
- **Why does `../storage/save_service.dart` connect `Community 3` to `Community 8`, `Community 7`?**
  _High betweenness centrality (0.071) - this node is a cross-community bridge._
- **What connects `main`, `package:dice_battler/features/battle/enemy_factory.dart`, `main` to the rest of the system?**
  _200 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Community 0` be split into smaller, more focused modules?**
  _Cohesion score 0.05 - nodes in this community are weakly interconnected._
- **Should `Community 1` be split into smaller, more focused modules?**
  _Cohesion score 0.07 - nodes in this community are weakly interconnected._
- **Should `Community 2` be split into smaller, more focused modules?**
  _Cohesion score 0.08 - nodes in this community are weakly interconnected._