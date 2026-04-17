# 04-01 Summary

## What Changed

- Added `SaveService` to persist `best_streak` and `tutorial_seen` with `shared_preferences`.
- Updated the home and results screens to show the saved best streak.
- Added a one-time tutorial dialog at run start and persisted the seen flag through `RunController`.
- Added persistence-focused tests for the save service, run controller, and widget surfaces.

## Verification

- `cd app && flutter analyze` passed.
- `cd app && flutter test` passed.

## Result

Phase 4 is complete and the app now meets the MVP persistence requirements for best streak and tutorial seen state.
