# Claude instructions for this project

Read these files in order before coding:
1. `PRD.md`
2. `TECHNICAL_DESIGN.md`
3. `IMPLEMENTATION_PLAN.md`
4. `QA_CHECKLIST.md`

## Non-negotiables
- Keep the actual Flutter code in `/app`
- Use Android only
- Stay inside MVP scope
- Keep code beginner-friendly and heavily named, not overly abstract
- Use placeholder visuals only
- Do not introduce backend, analytics, ads, multiplayer, login, or IAP
- Run `flutter analyze` and `flutter test` after each milestone
- Stop and report after the requested milestone instead of expanding scope

## Working style
- Prefer small files and feature-based folders
- Prefer pure Dart logic for rules and tests
- Keep UI simple first, polish second
- When a design choice is ambiguous, choose the simpler option that preserves the PRD
- If you want to add a dependency not already approved, justify it first in one sentence and wait for approval

## Output style
When you finish a milestone:
- list files added or changed
- list commands run
- list tests added or updated
- list known gaps against the current milestone
