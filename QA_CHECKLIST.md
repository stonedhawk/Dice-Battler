# QA Checklist: Dice Battler

## Manual functional checks
- App launches to home screen
- Start Run begins battle 1
- Three dice appear every turn
- Every die can be assigned exactly once
- Resolve button does nothing until all dice are assigned
- Attack damages enemy
- Block absorbs damage before HP
- Heal never exceeds max HP
- Enemy intent updates correctly each turn
- Reward screen appears after battle wins except final battle
- Selected reward changes player stats immediately
- Game over screen appears on death
- Victory screen appears after battle 10
- Best streak updates and survives restart

## Edge cases
- Player kills enemy before enemy acts
- Shield larger than incoming damage
- Heal on full HP
- Vitality reward when near full HP
- Last battle win skips reward screen and goes to victory
- Tutorial flag prevents repeat first-run tutorial

## Automated checks
Run:
```bash
cd app
flutter analyze
flutter test
```

## Performance sanity
- No obvious frame drops on a physical phone
- No unnecessary rebuild storms during a single turn

## Release blockers for MVP
Any of these block completion:
- crash during battle
- impossible to assign dice
- reward application corrupts state
- best streak does not persist
- game cannot be completed start to finish
