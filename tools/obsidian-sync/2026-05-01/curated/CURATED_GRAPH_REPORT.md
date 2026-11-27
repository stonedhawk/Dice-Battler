# Graph Report - Dice Battler Curated Graph  (2026-05-01)

## Corpus Check
- 53 files · ~12,661 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 181 nodes · 389 edges · 9 communities detected
- Extraction: 93% EXTRACTED · 7% INFERRED · 0% AMBIGUOUS · INFERRED: 29 edges (avg confidence: 0.88)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_md  plan  summary|md / plan / summary]]
- [[_COMMUNITY_dart  run  controller|dart / run / controller]]
- [[_COMMUNITY_dart  build  screen|dart / build / screen]]
- [[_COMMUNITY_dart  test  main|dart / test / main]]
- [[_COMMUNITY_dart  loadbeststreak  routes|dart / loadbeststreak / routes]]
- [[_COMMUNITY_battle  dart  screen|battle / dart / screen]]
- [[_COMMUNITY_dart  enemy  factory|dart / enemy / factory]]
- [[_COMMUNITY_dart  plugin  registrant|dart / plugin / registrant]]
- [[_COMMUNITY_analysis  options  yaml|analysis / options / yaml]]

## God Nodes (most connected - your core abstractions)
1. `package:flutter/material.dart` - 13 edges
2. `Phase 1: Project shell and rule engine` - 8 edges
3. `package:flutter_test/flutter_test.dart` - 8 edges
4. `Phase 2: Battle screen` - 7 edges
5. `Phase 3: Run flow and rewards` - 6 edges
6. `Phase 4: Persistence and polish` - 6 edges
7. `Phase 5: Stabilization` - 4 edges
8. `battle_models.dart` - 4 edges
9. `package:flutter/foundation.dart` - 2 edges
10. `reward_models.dart` - 2 edges

## Surprising Connections (you probably didn't know these)
- None detected - all connections are within the same source files.

## Hyperedges (group relationships)
- **Phase 1 Delivery** — phase_1, app_shell, battle_logic, enemy_generation, quality_gates [EXTRACTED 1.00]
- **Project Brain Loop** — gsd_workflow, quality_gates, second_brain [INFERRED 0.82]

## Communities

### Community 0 - "md / plan / summary"
Cohesion: 0.2
Nodes (14): App Shell, Battle Logic, Enemy Generation, Lean GSD Workflow, Persistence, Phase 1: Project shell and rule engine, Phase 2: Battle screen, Phase 3: Run flow and rewards (+6 more)

### Community 1 - "dart / run / controller"
Cohesion: 0.07
Nodes (8): dart:math, enemy_factory.dart, package:flutter/foundation.dart, run_state.dart, turn_resolver.dart, BattleController, RunController, _FakeSaveService

### Community 2 - "dart / build / screen"
Cohesion: 0.08
Nodes (12): app/app.dart, package:flutter/material.dart, package:flutter/services.dart, reward_models.dart, reward_service.dart, run_controller.dart, TutorialDialog, GameOverScreen (+4 more)

### Community 3 - "dart / test / main"
Cohesion: 0.08
Nodes (7): package:flutter_test/flutter_test.dart, DieModel, EnemyState, PlayerState, RewardService, RunState, _FakeSaveService

### Community 4 - "dart / loadbeststreak / routes"
Cohesion: 0.08
Nodes (9): package:shared_preferences/shared_preferences.dart, routes.dart, theme.dart, DiceBattlerApp, AppRoutes, HomeScreen, _HomeScreenState, SaveService (+1 more)

### Community 5 - "battle / dart / screen"
Cohesion: 0.15
Nodes (6): battle_controller.dart, BattleScreen, _BattleScreenState, _CombatantCard, _DieCard, _SummaryChip

### Community 6 - "dart / enemy / factory"
Cohesion: 0.18
Nodes (4): battle_models.dart, _EnemyDefinition, EnemyFactory, TurnOutcome

### Community 7 - "dart / plugin / registrant"
Cohesion: 0.5
Nodes (2): dart:io, _PluginRegistrant

### Community 8 - "analysis / options / yaml"
Cohesion: 1.0
Nodes (0): 

## Knowledge Gaps
- **42 isolated node(s):** `_PluginRegistrant`, `dart:io`, `DiceBattlerApp`, `routes.dart`, `theme.dart` (+37 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **Thin community `analysis / options / yaml`** (1 nodes): `analysis_options.yaml`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **What connects `_PluginRegistrant`, `dart:io`, `DiceBattlerApp` to the rest of the system?**
  _42 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `dart / run / controller` be split into smaller, more focused modules?**
  _Cohesion score 0.07 - nodes in this community are weakly interconnected._
- **Should `dart / build / screen` be split into smaller, more focused modules?**
  _Cohesion score 0.08 - nodes in this community are weakly interconnected._
- **Should `dart / test / main` be split into smaller, more focused modules?**
  _Cohesion score 0.08 - nodes in this community are weakly interconnected._
- **Should `dart / loadbeststreak / routes` be split into smaller, more focused modules?**
  _Cohesion score 0.08 - nodes in this community are weakly interconnected._