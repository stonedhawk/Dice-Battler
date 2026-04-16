# Start here

This folder is meant to be used as the **project root for planning**. The actual Flutter app should be created in the `/app` subfolder so the planning docs stay separate from generated source code.

## Recommended flow
1. Read `PRD.md`
2. Read `TECHNICAL_DESIGN.md`
3. Read `IMPLEMENTATION_PLAN.md`
4. Read `QA_CHECKLIST.md`
5. Let the agent read `CLAUDE.md` or `AGENTS.md`
6. Create the Flutter app in `/app`
7. Implement **Milestone 1 only**
8. Run analysis and tests before moving to the next milestone

## Commands
Create the app:
```bash
flutter create app --platforms=android --org com.example.offlinegames
```

After creation, install packages listed in the technical design:
```bash
cd app
flutter pub add shared_preferences
```

If the project uses Flame:
```bash
flutter pub add flame
```

Then return to the game folder and launch your agent from this folder, not from `/app`, so it can see the docs:
```bash
cd ..
claude
# or
codex
```

## Suggested first prompt
Use this exact prompt in Claude Code or Codex:

```text
Read CLAUDE.md or AGENTS.md first, then read PRD.md, TECHNICAL_DESIGN.md, IMPLEMENTATION_PLAN.md, and QA_CHECKLIST.md. Create the Flutter Android app in /app if it does not exist yet. Implement Milestone 1 only. Keep the code beginner-friendly, avoid extra packages, use placeholder art only, and do not add any feature that is marked out of scope. After coding, run flutter analyze and flutter test, then summarize what was completed and what remains.
```

## Rules for the first implementation pass
- Do not build the full game in one shot.
- Do not add audio, ads, analytics, backend, accounts, cloud saves, multiplayer, or monetization.
- Do not add extra packages unless the technical design explicitly allows them.
- Keep code readable enough that a beginner can follow it with AI help.
