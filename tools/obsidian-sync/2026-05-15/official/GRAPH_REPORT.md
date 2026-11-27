# Graph Report - .  (2026-05-15)

## Corpus Check
- Corpus is ~25,025 words - fits in a single context window. You may not need a graph.

## Summary
- 446 nodes · 496 edges · 44 communities detected
- Extraction: 98% EXTRACTED · 2% INFERRED · 0% AMBIGUOUS · INFERRED: 8 edges (avg confidence: 0.84)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Mvp Milestone Constraint|Mvp Milestone Constraint]]
- [[_COMMUNITY_Battle Enemy Factory|Battle Enemy Factory]]
- [[_COMMUNITY_Package Dice Battler|Package Dice Battler]]
- [[_COMMUNITY_Run Battle State|Run Battle State]]
- [[_COMMUNITY_Build Theme Buildapptheme|Build Theme Buildapptheme]]
- [[_COMMUNITY_Run Animatedbuilder Battlescreen|Run Animatedbuilder Battlescreen]]
- [[_COMMUNITY_Reward Build Icon|Reward Build Icon]]
- [[_COMMUNITY_Home Build Homescreen|Home Build Homescreen]]
- [[_COMMUNITY_Battle Actionlabel Backgroundcolor|Battle Actionlabel Backgroundcolor]]
- [[_COMMUNITY_Battle Actionlabel Backgroundcolor|Battle Actionlabel Backgroundcolor]]
- [[_COMMUNITY_Curated Add Project|Curated Add Project]]
- [[_COMMUNITY_Features Build Dicebattlerapp|Features Build Dicebattlerapp]]
- [[_COMMUNITY_Graphify Curated Append|Graphify Curated Append]]
- [[_COMMUNITY_Game Over Build|Game Over Build]]
- [[_COMMUNITY_Victory Build Scaffold|Victory Build Scaffold]]
- [[_COMMUNITY_Battle Advanceintent Copywith|Battle Advanceintent Copywith]]
- [[_COMMUNITY_Battle Advanceintent Copywith|Battle Advanceintent Copywith]]
- [[_COMMUNITY_Quality Gate Not|Quality Gate Not]]
- [[_COMMUNITY_Obsidian Sync Vault|Obsidian Sync Vault]]
- [[_COMMUNITY_Core Design Pillars|Core Design Pillars]]
- [[_COMMUNITY_Routes Approutes|Routes Approutes]]
- [[_COMMUNITY_Routes Approutes|Routes Approutes]]
- [[_COMMUNITY_Enemy Enemyfactory Pure|Enemy Enemyfactory Pure]]
- [[_COMMUNITY_Reward Pool Sharp|Reward Pool Sharp]]
- [[_COMMUNITY_Best Streak Tutorial|Best Streak Tutorial]]
- [[_COMMUNITY_Reward|Reward]]
- [[_COMMUNITY_Reward|Reward]]
- [[_COMMUNITY_Graphify Official Graph|Graphify Official Graph]]
- [[_COMMUNITY_Curated Graph Report|Curated Graph Report]]
- [[_COMMUNITY_Quality Gates Analyze|Quality Gates Analyze]]
- [[_COMMUNITY_Start Here|Start Here]]
- [[_COMMUNITY_Prd|Prd]]
- [[_COMMUNITY_Technical Design|Technical Design]]
- [[_COMMUNITY_Implementation Plan|Implementation Plan]]
- [[_COMMUNITY_Checklist|Checklist]]
- [[_COMMUNITY_Claude|Claude]]
- [[_COMMUNITY_Agents|Agents]]
- [[_COMMUNITY_Milestone Plan|Milestone Plan]]
- [[_COMMUNITY_Milestone Plan|Milestone Plan]]
- [[_COMMUNITY_Milestone Plan|Milestone Plan]]
- [[_COMMUNITY_Milestone Plan|Milestone Plan]]
- [[_COMMUNITY_Milestone Plan|Milestone Plan]]
- [[_COMMUNITY_Lean Gsd Workflow|Lean Gsd Workflow]]
- [[_COMMUNITY_Second Brain|Second Brain]]

## God Nodes (most connected - your core abstractions)
1. `package:flutter/material.dart` - 23 edges
2. `build_curated_extraction()` - 11 edges
3. `package:flutter_test/flutter_test.dart` - 8 edges
4. `battle_models.dart` - 8 edges
5. `package:dice_battler/features/battle/battle_models.dart` - 6 edges
6. `dart:math` - 6 edges
7. `../storage/save_service.dart` - 6 edges
8. `../battle/battle_models.dart` - 6 edges
9. `Exact MVP Rule Set` - 6 edges
10. `ExtractionBuilder` - 5 edges

## Surprising Connections (you probably didn't know these)
- `Core Design Pillars` --conceptually_related_to--> `Deterministic Game Logic via Pure Dart Functions`  [INFERRED]
  PRD.md → TECHNICAL_DESIGN.md
- `Deterministic Game Logic via Pure Dart Functions` --conceptually_related_to--> `Turn Resolution Order`  [INFERRED]
  TECHNICAL_DESIGN.md → PRD.md
- `EnemyFactory (pure Dart enemy generation)` --conceptually_related_to--> `Deterministic Enemy Lineup Table (Battles 1-10)`  [INFERRED]
  TECHNICAL_DESIGN.md → PRD.md
- `RewardService (pure Dart reward application)` --conceptually_related_to--> `Reward Pool (Sharp Edge/Iron Skin/Field Medicine/Vitality)`  [INFERRED]
  TECHNICAL_DESIGN.md → PRD.md
- `Local Save Requirements (best streak, tutorial flag)` --shares_data_with--> `Persistence Keys (best_streak, tutorial_seen)`  [INFERRED]
  PRD.md → TECHNICAL_DESIGN.md

## Hyperedges (group relationships)
- **Recommended Reading Flow** — START_HERE_doc, PRD_doc, TECHNICAL_DESIGN_doc, IMPLEMENTATION_PLAN_doc, QA_CHECKLIST_doc, CLAUDE_doc, AGENTS_doc [EXTRACTED 1.00]
- **Milestone Sequence (1-5)** — PLAN_milestone_1, PLAN_milestone_2, PLAN_milestone_3, PLAN_milestone_4, PLAN_milestone_5 [EXTRACTED 1.00]
- **Recommended Reading Flow** — START_HERE_doc, PRD_doc, TECHNICAL_DESIGN_doc, IMPLEMENTATION_PLAN_doc, QA_CHECKLIST_doc, CLAUDE_doc, AGENTS_doc [EXTRACTED 1.00]
- **Milestone Sequence (1-5)** — PLAN_milestone_1, PLAN_milestone_2, PLAN_milestone_3, PLAN_milestone_4, PLAN_milestone_5 [EXTRACTED 1.00]
- **Recommended Reading Flow** — start_here_doc, prd_doc, technical_design_doc, implementation_plan_doc, qa_checklist_doc, claude_doc, agents_doc [EXTRACTED 1.00]
- **Milestone Sequence (1-5)** — plan_milestone_1, plan_milestone_2, plan_milestone_3, plan_milestone_4, plan_milestone_5 [EXTRACTED 1.00]
- **Project Brain Loop** — concept_gsd_workflow, quality_gates_flutter_analyze_test, concept_second_brain [INFERRED 0.82]

## Communities

### Community 0 - "Mvp Milestone Constraint"
Cohesion: 0.04
Nodes (60): Constraint: Android only, Concept: App Shell, Concept: Battle Logic / Rule Engine, Concept: Enemy Generation, UI: Material 3, Constraint: No backend/services/network calls, Constraint: Offline only (no networking), Constraint: Placeholder art only (+52 more)

### Community 1 - "Battle Enemy Factory"
Cohesion: 0.05
Nodes (43): BattleController, cycleDieAction, _nextActionFor, _resetBattle, resolveCurrentTurn, restartBattle, battleMultiplierForBattle, createEnemyForBattle (+35 more)

### Community 2 - "Package Dice Battler"
Cohesion: 0.06
Nodes (32): SaveService, main, main, main, BattleController, copyWithMemory, _FakeSaveService, main (+24 more)

### Community 3 - "Run Battle State"
Cohesion: 0.06
Nodes (33): BattleController, _battleControllerFactory, _buildBattleController, _completeBattleDefeat, _completeBattleVictory, _defaultBattleControllerFactory, _recordBestStreak, _resetShield (+25 more)

### Community 4 - "Build Theme Buildapptheme"
Cohesion: 0.06
Nodes (25): app/app.dart, buildAppTheme, ThemeData, AlertDialog, build, TutorialDialog, build, GameOverScreen (+17 more)

### Community 5 - "Run Animatedbuilder Battlescreen"
Cohesion: 0.08
Nodes (26): AnimatedBuilder, BattleScreen, build, dispose, GameOverScreen, initState, RewardScreen, RunScreen (+18 more)

### Community 6 - "Reward Build Icon"
Cohesion: 0.08
Nodes (22): build, Icon, RewardScreen, Scaffold, SizedBox, Text, applyReward, descriptionFor (+14 more)

### Community 7 - "Home Build Homescreen"
Cohesion: 0.1
Nodes (20): build, HomeScreen, _HomeScreenState, initState, _loadBestStreak, Scaffold, SizedBox, Spacer (+12 more)

### Community 8 - "Battle Actionlabel Backgroundcolor"
Cohesion: 0.1
Nodes (20): _actionLabel, _backgroundColor, BattleScreen, _BattleScreenState, build, Card, Color, _CombatantCard (+12 more)

### Community 9 - "Battle Actionlabel Backgroundcolor"
Cohesion: 0.1
Nodes (19): _actionLabel, _backgroundColor, BattleScreen, _BattleScreenState, build, Card, Color, _CombatantCard (+11 more)

### Community 10 - "Curated Add Project"
Cohesion: 0.26
Nodes (11): build_curated_extraction(), classify_file(), derive_community_labels(), ExtractionBuilder, import_target(), infer_systems(), main(), parse_dart_symbols() (+3 more)

### Community 11 - "Features Build Dicebattlerapp"
Cohesion: 0.21
Nodes (11): build, DiceBattlerApp, MaterialApp, ../features/battle/battle_screen.dart, ../features/home/home_screen.dart, ../features/run/run_screen.dart, build, DiceBattlerApp (+3 more)

### Community 12 - "Graphify Curated Append"
Cohesion: 0.25
Nodes (8): Append Block 2026-05-01, Append Block 2026-05-15, Curated Graph Generation Script (tools/generate_curated_project_graph.py), Graphify Outputs (Curated), Graphify Outputs (Official), Graphify Update Command (graphify update .), Sync Entry 2026-05-01, Sync Entry 2026-05-15

### Community 13 - "Game Over Build"
Cohesion: 0.29
Nodes (6): build, GameOverScreen, Scaffold, SizedBox, Spacer, Text

### Community 14 - "Victory Build Scaffold"
Cohesion: 0.29
Nodes (6): build, Scaffold, SizedBox, Spacer, Text, VictoryScreen

### Community 15 - "Battle Advanceintent Copywith"
Cohesion: 0.33
Nodes (5): advanceIntent, copyWith, DieModel, EnemyState, PlayerState

### Community 16 - "Battle Advanceintent Copywith"
Cohesion: 0.33
Nodes (5): advanceIntent, copyWith, DieModel, EnemyState, PlayerState

### Community 17 - "Quality Gate Not"
Cohesion: 0.67
Nodes (3): Quality Gate: flutter analyze, Quality Gate: flutter test, Reason: Flutter toolchain not available (flutter not found)

### Community 18 - "Obsidian Sync Vault"
Cohesion: 0.67
Nodes (3): Copy sync payload into Obsidian vault, Obsidian Entry 2026-05-01 Sync, Reason: Sandbox cannot write to Obsidian vault path

### Community 19 - "Core Design Pillars"
Cohesion: 0.67
Nodes (3): Core Design Pillars, Deterministic Game Logic via Pure Dart Functions, Turn Resolution Order

### Community 20 - "Routes Approutes"
Cohesion: 1.0
Nodes (1): AppRoutes

### Community 21 - "Routes Approutes"
Cohesion: 1.0
Nodes (1): AppRoutes

### Community 22 - "Enemy Enemyfactory Pure"
Cohesion: 1.0
Nodes (2): EnemyFactory (pure Dart enemy generation), Deterministic Enemy Lineup Table (Battles 1-10)

### Community 23 - "Reward Pool Sharp"
Cohesion: 1.0
Nodes (2): Reward Pool (Sharp Edge/Iron Skin/Field Medicine/Vitality), RewardService (pure Dart reward application)

### Community 24 - "Best Streak Tutorial"
Cohesion: 1.0
Nodes (2): Local Save Requirements (best streak, tutorial flag), Persistence Keys (best_streak, tutorial_seen)

### Community 25 - "Reward"
Cohesion: 1.0
Nodes (0): 

### Community 26 - "Reward"
Cohesion: 1.0
Nodes (0): 

### Community 27 - "Graphify Official Graph"
Cohesion: 1.0
Nodes (1): Graphify Official Graph Report 2026-05-15

### Community 28 - "Curated Graph Report"
Cohesion: 1.0
Nodes (1): Curated Graph Report 2026-05-15

### Community 29 - "Quality Gates Analyze"
Cohesion: 1.0
Nodes (1): Quality Gates (flutter analyze + flutter test)

### Community 30 - "Start Here"
Cohesion: 1.0
Nodes (1): START_HERE.md

### Community 31 - "Prd"
Cohesion: 1.0
Nodes (1): PRD.md

### Community 32 - "Technical Design"
Cohesion: 1.0
Nodes (1): TECHNICAL_DESIGN.md

### Community 33 - "Implementation Plan"
Cohesion: 1.0
Nodes (1): IMPLEMENTATION_PLAN.md

### Community 34 - "Checklist"
Cohesion: 1.0
Nodes (1): QA_CHECKLIST.md

### Community 35 - "Claude"
Cohesion: 1.0
Nodes (1): CLAUDE.md

### Community 36 - "Agents"
Cohesion: 1.0
Nodes (1): AGENTS.md

### Community 37 - "Milestone Plan"
Cohesion: 1.0
Nodes (1): Milestone 1 Plan

### Community 38 - "Milestone Plan"
Cohesion: 1.0
Nodes (1): Milestone 2 Plan

### Community 39 - "Milestone Plan"
Cohesion: 1.0
Nodes (1): Milestone 3 Plan

### Community 40 - "Milestone Plan"
Cohesion: 1.0
Nodes (1): Milestone 4 Plan

### Community 41 - "Milestone Plan"
Cohesion: 1.0
Nodes (1): Milestone 5 Plan

### Community 42 - "Lean Gsd Workflow"
Cohesion: 1.0
Nodes (1): Lean GSD Workflow

### Community 43 - "Second Brain"
Cohesion: 1.0
Nodes (1): Second Brain

## Knowledge Gaps
- **315 isolated node(s):** `main`, `package:dice_battler/features/battle/enemy_factory.dart`, `main`, `package:dice_battler/features/battle/turn_resolver.dart`, `main` (+310 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **Thin community `Routes Approutes`** (2 nodes): `routes.dart`, `AppRoutes`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Routes Approutes`** (2 nodes): `routes.dart`, `AppRoutes`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Enemy Enemyfactory Pure`** (2 nodes): `EnemyFactory (pure Dart enemy generation)`, `Deterministic Enemy Lineup Table (Battles 1-10)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Reward Pool Sharp`** (2 nodes): `Reward Pool (Sharp Edge/Iron Skin/Field Medicine/Vitality)`, `RewardService (pure Dart reward application)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Best Streak Tutorial`** (2 nodes): `Local Save Requirements (best streak, tutorial flag)`, `Persistence Keys (best_streak, tutorial_seen)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Reward`** (1 nodes): `reward_models.dart`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Reward`** (1 nodes): `reward_models.dart`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Graphify Official Graph`** (1 nodes): `Graphify Official Graph Report 2026-05-15`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Curated Graph Report`** (1 nodes): `Curated Graph Report 2026-05-15`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Quality Gates Analyze`** (1 nodes): `Quality Gates (flutter analyze + flutter test)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Start Here`** (1 nodes): `START_HERE.md`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Prd`** (1 nodes): `PRD.md`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Technical Design`** (1 nodes): `TECHNICAL_DESIGN.md`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Implementation Plan`** (1 nodes): `IMPLEMENTATION_PLAN.md`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Checklist`** (1 nodes): `QA_CHECKLIST.md`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Claude`** (1 nodes): `CLAUDE.md`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Agents`** (1 nodes): `AGENTS.md`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Milestone Plan`** (1 nodes): `Milestone 1 Plan`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Milestone Plan`** (1 nodes): `Milestone 2 Plan`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Milestone Plan`** (1 nodes): `Milestone 3 Plan`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Milestone Plan`** (1 nodes): `Milestone 4 Plan`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Milestone Plan`** (1 nodes): `Milestone 5 Plan`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Lean Gsd Workflow`** (1 nodes): `Lean GSD Workflow`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Second Brain`** (1 nodes): `Second Brain`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `package:flutter/material.dart` connect `Build Theme Buildapptheme` to `Package Dice Battler`, `Run Animatedbuilder Battlescreen`, `Reward Build Icon`, `Home Build Homescreen`, `Battle Actionlabel Backgroundcolor`, `Battle Actionlabel Backgroundcolor`, `Features Build Dicebattlerapp`, `Game Over Build`, `Victory Build Scaffold`?**
  _High betweenness centrality (0.338) - this node is a cross-community bridge._
- **Why does `battle_models.dart` connect `Battle Enemy Factory` to `Battle Actionlabel Backgroundcolor`, `Battle Actionlabel Backgroundcolor`?**
  _High betweenness centrality (0.114) - this node is a cross-community bridge._
- **Why does `../storage/save_service.dart` connect `Home Build Homescreen` to `Run Battle State`, `Run Animatedbuilder Battlescreen`?**
  _High betweenness centrality (0.078) - this node is a cross-community bridge._
- **What connects `main`, `package:dice_battler/features/battle/enemy_factory.dart`, `main` to the rest of the system?**
  _315 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Mvp Milestone Constraint` be split into smaller, more focused modules?**
  _Cohesion score 0.04 - nodes in this community are weakly interconnected._
- **Should `Battle Enemy Factory` be split into smaller, more focused modules?**
  _Cohesion score 0.05 - nodes in this community are weakly interconnected._
- **Should `Package Dice Battler` be split into smaller, more focused modules?**
  _Cohesion score 0.06 - nodes in this community are weakly interconnected._