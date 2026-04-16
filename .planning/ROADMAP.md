# Roadmap: Dice Battler

**Created:** 2026-04-16
**Mode:** Lean GSD

## Current Milestone

MVP delivery for the offline Android Flutter game described in the project docs.

## Phases

### Phase 1: Project shell and rule engine

**Goal:** Create the `/app` shell, home screen scaffold, core models, pure turn resolver, pure enemy factory, and Phase 1 tests.
**Requirements:** APP-01, APP-02, RULE-01, RULE-02, RULE-03, RULE-04, RULE-05, TEST-01
**Plans:** 1

Plans:
- [ ] 01-01-PLAN.md — Bootstrap lean GSD docs, add the Flutter shell, implement deterministic battle logic, and add Phase 1 tests

### Phase 2: Battle screen

**Goal:** Build one full playable battle loop in the UI.
**Requirements:** APP-01
**Depends on:** Phase 1
**Plans:** 1

Plans:
- [ ] TBD (run `$gsd-plan-phase 2` to break down)

### Phase 3: Run flow and rewards

**Goal:** Connect the single battle into the full 10-battle run with rewards and results screens.
**Requirements:** RUN-01, RUN-02, RWRD-01, RWRD-02, RSLT-01
**Depends on:** Phase 2
**Plans:** 1

Plans:
- [ ] TBD (run `$gsd-plan-phase 3` to break down)

### Phase 4: Persistence and polish

**Goal:** Add local persistence for best streak and tutorial state, plus light UI cleanup and broader smoke tests.
**Requirements:** SAVE-01, SAVE-02, TEST-02
**Depends on:** Phase 3
**Plans:** 1

Plans:
- [ ] TBD (run `$gsd-plan-phase 4` to break down)

### Phase 5: Stabilization

**Goal:** Fix edge cases, trim dead code, close test gaps, and confirm no scope creep entered the MVP.
**Requirements:** TEST-01, TEST-02
**Depends on:** Phase 4
**Plans:** 1

Plans:
- [ ] TBD (run `$gsd-plan-phase 5` to break down)

---
*Last updated: 2026-04-16 after lean GSD bootstrap*
