# AGENTS.md

Read these files before doing any work:
1. `PRD.md`
2. `TECHNICAL_DESIGN.md`
3. `IMPLEMENTATION_PLAN.md`
4. `QA_CHECKLIST.md`

## Project conventions
- Project planning docs live in this folder
- Flutter app source must live in `/app`
- Android only
- Offline only
- Placeholder art only
- Beginner-friendly code over clever code
- Do not expand scope beyond MVP
- Do not add backend, analytics, ads, login, multiplayer, cloud save, or IAP

## Approved dependencies
- `shared_preferences`
- `flame` only if explicitly called for in `TECHNICAL_DESIGN.md`

## Quality gates
Before reporting completion for any milestone:
```bash
cd app
flutter analyze
flutter test
```

## Implementation behavior
- Implement one milestone at a time
- Prefer pure functions for game rules so they are easy to test
- Keep platform-specific code to a minimum
- Use current stable Flutter defaults unless the docs explicitly say otherwise
- Favor deterministic game logic where possible so tests stay reliable
