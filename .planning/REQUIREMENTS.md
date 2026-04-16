# Requirements: Dice Battler

**Defined:** 2026-04-16
**Core Value:** Ship a tiny, deterministic tactics game that is actually finishable and easy for a beginner to understand.

## v1 Requirements

### App Shell

- [ ] **APP-01**: Player can launch the app to a readable home screen with a Start Run entry point.
- [ ] **APP-02**: The app uses Material 3, portrait orientation, and placeholder-only presentation.

### Combat Rules

- [ ] **RULE-01**: The game models three six-sided dice per turn with exactly one assigned action per die.
- [ ] **RULE-02**: Player turn resolution follows the documented order for attack, block, heal, and enemy retaliation.
- [ ] **RULE-03**: Shield absorbs incoming damage before HP and resets at the end of the enemy turn.
- [ ] **RULE-04**: Healing uses `ceil(die / 2) + heal bonus` and never exceeds max HP.
- [ ] **RULE-05**: Enemy archetypes and battle scaling are deterministic and reproducible from battle number.

### Run Flow

- [ ] **RUN-01**: A run contains a fixed 10-battle lineup with one player character and three enemy archetypes.
- [ ] **RUN-02**: The player can progress through battles, rewards, victory, and game over without extra systems.

### Rewards And Results

- [ ] **RWRD-01**: After battles 1 through 9, the player chooses one of three unique rewards from the fixed reward pool.
- [ ] **RWRD-02**: Reward effects apply immediately and do not add rerolls, rarity, or removal systems.
- [ ] **RSLT-01**: The app shows a game over screen on defeat and a victory screen after battle 10.

### Persistence

- [ ] **SAVE-01**: The app stores `best_streak` locally across restarts.
- [ ] **SAVE-02**: The app stores `tutorial_seen` locally across restarts.

### Quality

- [ ] **TEST-01**: Unit tests cover turn resolution edge cases and enemy scaling.
- [ ] **TEST-02**: Widget or smoke tests cover the basic screen shell and key UI states as milestones progress.

## v2 Requirements

### Future Ideas

- **FUT-01**: Add extra content only after the MVP is complete and validated.

## Out of Scope

| Feature | Reason |
|---------|--------|
| Backend or online sync | The MVP is offline-only and should stay finishable |
| Login, accounts, or cloud save | Not required for the core loop |
| Ads, analytics, or IAP | Explicitly excluded in the project docs |
| Classes, shops, bosses, or map nodes | Scope creep beyond the MVP |
| Audio pipeline or custom art pipeline | Placeholder art only for MVP |

## Traceability

| Requirement | Phase | Status |
|-------------|-------|--------|
| APP-01 | Phase 1 | In Progress |
| APP-02 | Phase 1 | In Progress |
| RULE-01 | Phase 1 | In Progress |
| RULE-02 | Phase 1 | In Progress |
| RULE-03 | Phase 1 | In Progress |
| RULE-04 | Phase 1 | In Progress |
| RULE-05 | Phase 1 | In Progress |
| TEST-01 | Phase 1 | In Progress |
| RUN-01 | Phase 3 | Pending |
| RUN-02 | Phase 3 | Pending |
| RWRD-01 | Phase 3 | Pending |
| RWRD-02 | Phase 3 | Pending |
| RSLT-01 | Phase 3 | Pending |
| SAVE-01 | Phase 4 | Pending |
| SAVE-02 | Phase 4 | Pending |
| TEST-02 | Phase 4 | Pending |

**Coverage:**
- v1 requirements: 16 total
- Mapped to phases: 16
- Unmapped: 0 ✓

---
*Requirements defined: 2026-04-16*
*Last updated: 2026-04-16 after lean GSD bootstrap*
