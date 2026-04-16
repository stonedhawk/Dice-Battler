# Dice Battler

## What This Is

Dice Battler is a small, fully offline, turn-based Android game built in Flutter. The player clears a 10-battle run by rolling three dice each turn and assigning them to attack, block, or heal in a fast, readable combat loop.

## Core Value

Ship a tiny, deterministic tactics game that is actually finishable and easy for a beginner to understand.

## Requirements

### Validated

(None yet — ship to validate)

### Active

- [ ] Deliver the MVP as a plain Flutter app under `/app`.
- [ ] Keep all core combat rules deterministic, pure, and easy to test.
- [ ] Ship the 10-battle offline run with fixed enemies, simple rewards, and local-only persistence.

### Out of Scope

- Backend, analytics, ads, accounts, cloud save, multiplayer, and online sync — explicitly excluded by the project docs.
- Audio pipeline, content pipeline, heavy animation systems, and custom art workflows — not needed for the MVP loop.
- Classes, shops, map paths, bosses, relic trees, inventory, and advanced status systems — scope creep beyond the MVP.

## Context

- Planning docs live at the project root and are the source of truth for scope and architecture.
- The Flutter app source must live in `/app`.
- The technical design requires a plain Flutter app, Material 3, Android-only support, offline-only behavior, and `shared_preferences` as the only approved dependency.
- Milestone 1 focuses on the app shell, home screen, pure rule engine, pure enemy factory, and rule-engine tests.

## Constraints

- **Tech stack**: Plain Flutter and Dart — easier for a beginner to follow and test than a game engine.
- **Platform**: Android only — keeps the MVP finishable.
- **Connectivity**: Offline only — no backend or networking work.
- **Dependencies**: `shared_preferences` only — avoid unnecessary packages and state-management frameworks.
- **Code style**: Beginner-friendly code over clever abstractions — the user should be able to extend it with AI help.
- **Determinism**: Pure functions for game rules — keeps tests reliable and behavior understandable.

## Key Decisions

| Decision | Rationale | Outcome |
|----------|-----------|---------|
| Use a lean GSD workflow | The repo already has clear planning docs, so heavy ideation would add overhead | ✓ Good |
| Map one milestone to one GSD phase | Matches the project docs and keeps progress easy to track | ✓ Good |
| Start with Milestone 1 only | The docs explicitly forbid building the whole game in one pass | ✓ Good |
| Use a plain Flutter app, not Flame | The game is turn-based and UI-first | ✓ Good |

---
*Last updated: 2026-04-16 after lean GSD bootstrap and Phase 1 setup*
