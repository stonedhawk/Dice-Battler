# Implementation Plan: Dice Battler

## Milestone 1: Project shell and rule engine
### Goal
Create the app shell, home screen, core models, and pure Dart turn resolver.

### Deliverables
- Flutter project exists in `/app`
- home screen with Start Run button
- domain models for player, enemy, die, reward, run state
- pure `turn_resolver.dart`
- pure `enemy_factory.dart`
- unit tests for rule engine

### Done when
- tests pass
- `flutter analyze` passes
- no gameplay UI yet beyond basic shell

## Milestone 2: Battle screen
### Goal
Build one full battle loop.

### Deliverables
- battle screen
- dice roll generation
- assignment UI
- resolve turn flow
- enemy intent display
- win/lose resolution for a single battle

### Done when
- user can beat or lose one battle from UI
- battle state resets correctly on restart

## Milestone 3: Run flow and rewards
### Goal
Connect battles into a 10-battle run.

### Deliverables
- deterministic enemy lineup
- reward screen after wins
- reward application
- progression to next battle
- game over and victory screens

### Done when
- full run is playable start to finish

## Milestone 4: Persistence and polish
### Goal
Add local persistence and light UI polish.

### Deliverables
- best streak save/load
- tutorial seen save/load
- cleaner spacing and labels
- extra widget tests

### Done when
- data survives app restart
- screens are readable and stable

## Milestone 5: Bug fixing
### Goal
Stabilize and trim.

### Deliverables
- fix edge cases
- remove dead code
- improve comments
- verify no scope creep entered the codebase

## Scope guardrails
If a proposed task adds:
- new reward systems
- classes
- status effects
- shops
- map nodes
- bosses

then reject it for MVP.
