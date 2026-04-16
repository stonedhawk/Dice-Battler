# PRD: Dice Battler

## 1. Product summary
Dice Battler is a small, fully offline, turn-based combat game for Android. The player fights through a 10-battle run by rolling three dice each turn and assigning each die to **Attack**, **Block**, or **Heal**.

This project exists for two reasons:
1. Ship a small game that is actually finishable.
2. Learn Flutter fundamentals without jumping into real-time game engine complexity.

## 2. Product goals
- Build and ship a small offline Android game with no backend.
- Teach core mobile game architecture in Flutter:
  - screen flow
  - local state
  - deterministic game rules
  - local persistence
  - unit and widget testing
- Keep the code simple enough for an AI-assisted beginner to understand and extend.

## 3. Target player
- Casual mobile players
- Session length: 2 to 5 minutes
- Wants short, readable tactical choices
- Okay with simple visuals if the loop feels clean

## 4. Core design pillars
- **Small and finishable**
- **Readable choices every turn**
- **Deterministic and testable rules**
- **No feature creep**

## 5. MVP scope
### Included
- Android only
- Offline only
- One run = 10 battles
- One player character
- Three enemy archetypes
- Three six-sided dice per turn
- Three actions: Attack, Block, Heal
- Reward selection after battles 1 to 9
- Run complete screen
- Game over screen
- Local save for:
  - best battles-cleared streak
  - tutorial seen flag

### Excluded
- Deckbuilding
- Equipment
- Multiple classes
- Shops
- Status effects beyond shield
- Ads
- Analytics
- Online sync
- Account systems
- Audio system
- Localization
- Accessibility extras beyond basic readable UI

## 6. Core gameplay loop
1. Player starts a new run.
2. Battle begins against one enemy.
3. Three dice are rolled automatically.
4. Player assigns each die to Attack, Block, or Heal.
5. Player taps **Resolve Turn**.
6. Player actions resolve.
7. If enemy survives, enemy performs its telegraphed attack.
8. If player survives, next turn begins.
9. If enemy dies:
   - increment battles cleared
   - if battle 10 was cleared, show victory
   - otherwise show reward selection
10. Repeat until player dies or clears all 10 battles.

## 7. Exact rule set for MVP
### Player starting stats
- Max HP: 30
- Current HP: 30
- Attack bonus: 0
- Block bonus: 0
- Heal bonus: 0
- Shield: 0

### Dice
- 3 dice per turn
- Each die has an integer value from 1 to 6
- Each die must be assigned to exactly one action before turn resolution

### Actions
For each die assigned:

#### Attack
- Damage dealt = die value + current attack bonus

#### Block
- Shield gained = die value + current block bonus

#### Heal
- Healing gained = ceil(die value / 2) + current heal bonus
- Healing cannot exceed max HP

### Resolution order
1. Sum all assigned attack damage and apply to enemy HP
2. Sum all assigned block and add to player shield
3. Sum all assigned healing and heal player
4. If enemy HP is now 0 or lower, battle ends immediately
5. Enemy intent damage is applied to player
6. Player shield absorbs incoming damage first
7. Remaining damage reduces HP
8. Shield resets to 0 at end of enemy turn

### Enemy archetypes
#### Striker
- Base HP: 22
- Intent pattern: 6, 8, 6, repeat

#### Brute
- Base HP: 30
- Intent pattern: 4, 10, 4, repeat

#### Trickster
- Base HP: 26
- Intent pattern: 5, 5, 7, repeat

### Battle scaling by battle number
- Battles 1 to 3: tier 1, multiplier 1.0
- Battles 4 to 7: tier 2, multiplier 1.25
- Battles 8 to 10: tier 3, multiplier 1.5

Apply multiplier to:
- enemy HP
- enemy intent damage

Round down final values only after multiplication.

### Enemy lineup generation
Use a deterministic battle table for the first playable version:
1. Striker
2. Trickster
3. Brute
4. Striker
5. Trickster
6. Brute
7. Striker
8. Trickster
9. Brute
10. Brute

The AI should not invent extra encounter systems for MVP.

## 8. Rewards
After each victory except the final battle, present **3 unique reward choices** sampled from the fixed reward pool below.

### Reward pool
- **Sharp Edge**: +1 attack bonus
- **Iron Skin**: +1 block bonus
- **Field Medicine**: +1 heal bonus
- **Vitality**: +4 max HP and heal 4 immediately

### Reward rules
- Show 3 unique choices each time
- Player picks exactly 1
- Reward applies instantly
- No reward rerolls in MVP
- No rarity system
- No reward removal

## 9. UX and screen list
### Screens
- Home screen
- Tutorial modal or first-run guidance
- Battle screen
- Reward screen
- Game over screen
- Victory screen

### Battle screen content
- Player HP
- Enemy HP
- Current enemy intent damage
- Three dice with assignment state
- Attack / Block / Heal target areas or segmented assignment UI
- Resolve Turn button
- Simple battle log area or last action summary

## 10. Visual direction
- Material 3 UI
- Portrait orientation
- Clean card-based presentation
- Placeholder art only:
  - colored shapes
  - icons
  - text labels
- No custom art pipeline for MVP

## 11. Success criteria
The MVP is successful if:
- A new player can start a run in under 10 seconds
- A full run can be completed in under 5 minutes
- The game is fully playable offline
- The core rules are understandable without external documentation
- Tests cover turn resolution and reward application
- Scope stays small enough to finish

## 12. Risks and anti-goals
### Main risk
Turning a tiny tactics game into a fake Slay the Spire clone.

### Anti-goals
Do not add:
- relic trees
- map paths
- classes
- buffs and debuffs
- energy systems
- cards
- rerolls
- boss phases
- advanced animation systems
