# Graph Report - Dice Battler Curated Graph  (2026-05-15)

## Corpus Check
- 86 files · ~22,167 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 287 nodes · 612 edges · 10 communities detected
- Extraction: 95% EXTRACTED · 5% INFERRED · 0% AMBIGUOUS · INFERRED: 29 edges (avg confidence: 0.88)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_dart  build  screen|dart / build / screen]]
- [[_COMMUNITY_md  plan  summary|md / plan / summary]]
- [[_COMMUNITY_dart  test  main|dart / test / main]]
- [[_COMMUNITY_dart  battle  enemy|dart / battle / enemy]]
- [[_COMMUNITY_dart  loadbeststreak  home|dart / loadbeststreak / home]]
- [[_COMMUNITY_dart  build  battle|dart / build / battle]]
- [[_COMMUNITY_dart  run  models|dart / run / models]]
- [[_COMMUNITY_main  dart  app|main / dart / app]]
- [[_COMMUNITY_dart  plugin  registrant|dart / plugin / registrant]]
- [[_COMMUNITY_analysis  options  yaml|analysis / options / yaml]]

## God Nodes (most connected - your core abstractions)
1. `package:flutter/material.dart` - 23 edges
2. `Phase 1: Project shell and rule engine` - 9 edges
3. `Phase 2: Battle screen` - 8 edges
4. `battle_models.dart` - 8 edges
5. `package:flutter_test/flutter_test.dart` - 8 edges
6. `Phase 3: Run flow and rewards` - 7 edges
7. `Phase 4: Persistence and polish` - 7 edges
8. `Phase 5: Stabilization` - 5 edges
9. `package:flutter/foundation.dart` - 4 edges
10. `reward_models.dart` - 4 edges

## Surprising Connections (you probably didn't know these)
- None detected - all connections are within the same source files.

## Hyperedges (group relationships)
- **Phase 1 Delivery** — phase_1, app_shell, battle_logic, enemy_generation, quality_gates [EXTRACTED 1.00]
- **Project Brain Loop** — gsd_workflow, quality_gates, second_brain [INFERRED 0.82]

## Communities

### Community 0 - "dart / build / screen"
Cohesion: 0.05
Nodes (17): package:flutter/material.dart, reward_models.dart, reward_service.dart, run_controller.dart, TutorialDialog, GameOverScreen, VictoryScreen, RewardScreen (+9 more)

### Community 1 - "md / plan / summary"
Cohesion: 0.18
Nodes (14): App Shell, Battle Logic, Enemy Generation, Lean GSD Workflow, Persistence, Phase 1: Project shell and rule engine, Phase 2: Battle screen, Phase 3: Run flow and rewards (+6 more)

### Community 2 - "dart / test / main"
Cohesion: 0.06
Nodes (8): package:flutter_test/flutter_test.dart, DieModel, EnemyState, PlayerState, RewardService, RunController, RunState, _FakeSaveService

### Community 3 - "dart / battle / enemy"
Cohesion: 0.06
Nodes (13): battle_models.dart, dart:math, enemy_factory.dart, package:flutter/foundation.dart, turn_resolver.dart, BattleController, _EnemyDefinition, EnemyFactory (+5 more)

### Community 4 - "dart / loadbeststreak / home"
Cohesion: 0.06
Nodes (10): package:shared_preferences/shared_preferences.dart, AppRoutes, HomeScreen, _HomeScreenState, SaveService, _FakeSaveService, AppRoutes, HomeScreen (+2 more)

### Community 5 - "dart / build / battle"
Cohesion: 0.06
Nodes (15): battle_controller.dart, routes.dart, theme.dart, DiceBattlerApp, BattleScreen, _BattleScreenState, _CombatantCard, _DieCard (+7 more)

### Community 6 - "dart / run / models"
Cohesion: 0.08
Nodes (7): run_state.dart, DieModel, EnemyState, PlayerState, RewardService, RunController, RunState

### Community 7 - "main / dart / app"
Cohesion: 0.4
Nodes (2): app/app.dart, package:flutter/services.dart

### Community 8 - "dart / plugin / registrant"
Cohesion: 0.5
Nodes (2): dart:io, _PluginRegistrant

### Community 9 - "analysis / options / yaml"
Cohesion: 1.0
Nodes (0): 

## Knowledge Gaps
- **57 isolated node(s):** `_PluginRegistrant`, `dart:io`, `DiceBattlerApp`, `AppRoutes`, `BattleController` (+52 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **Thin community `analysis / options / yaml`** (1 nodes): `analysis_options.yaml`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **What connects `_PluginRegistrant`, `dart:io`, `DiceBattlerApp` to the rest of the system?**
  _57 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `dart / build / screen` be split into smaller, more focused modules?**
  _Cohesion score 0.05 - nodes in this community are weakly interconnected._
- **Should `dart / test / main` be split into smaller, more focused modules?**
  _Cohesion score 0.06 - nodes in this community are weakly interconnected._
- **Should `dart / battle / enemy` be split into smaller, more focused modules?**
  _Cohesion score 0.06 - nodes in this community are weakly interconnected._
- **Should `dart / loadbeststreak / home` be split into smaller, more focused modules?**
  _Cohesion score 0.06 - nodes in this community are weakly interconnected._