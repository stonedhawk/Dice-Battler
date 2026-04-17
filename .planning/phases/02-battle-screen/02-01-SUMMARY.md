# 02-01 Summary

## What Changed

- Added `BattleController` to own dice assignment, turn resolution, rerolls, and restart behavior.
- Replaced the placeholder battle screen with a playable one-battle UI that shows enemy intent, player state, dice assignments, and a battle log.
- Added widget tests for disabled resolve behavior and a complete UI win/restart flow.

## Verification

- `cd app && flutter analyze` passed.
- `cd app && flutter test` passed.

## Result

Phase 2 is complete and ready to feed into the 10-battle run flow.
