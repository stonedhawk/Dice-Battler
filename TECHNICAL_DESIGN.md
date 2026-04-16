# Technical Design: Dice Battler

Checked against official setup docs on 2026-04-16.

## 1. Technical summary
Dice Battler should be implemented as a **plain Flutter app**, not a Flame game.

Reason:
- turn-based
- UI-first
- minimal animation needs
- easier for a beginner to understand
- easier to unit test

## 2. Stack
- Flutter
- Dart
- Android only
- Material 3
- `shared_preferences` for local persistence
- No backend
- No services
- No network calls

## 3. Project layout
The actual generated Flutter app must live in `/app`.

Recommended structure inside `/app/lib`:
```text
lib/
  main.dart
  app/
    app.dart
    routes.dart
    theme.dart
  features/
    home/
      home_screen.dart
    battle/
      battle_screen.dart
      battle_controller.dart
      battle_models.dart
      turn_resolver.dart
      enemy_factory.dart
    rewards/
      reward_screen.dart
      reward_models.dart
      reward_service.dart
    run/
      run_controller.dart
      run_state.dart
    results/
      game_over_screen.dart
      victory_screen.dart
    storage/
      save_service.dart
  shared/
    widgets/
    utils/
```

## 4. Architectural choice
Use a **feature-based folder structure** plus `ChangeNotifier` or `ValueNotifier` for local state.

Do not add a heavy state-management package for MVP.

Recommended ownership:
- `RunController`: owns current run, battle index, reward flow, best streak updates
- `BattleController`: owns current battle screen state, dice assignments, resolve action
- `SaveService`: wraps `shared_preferences`
- `TurnResolver`: pure Dart logic for deterministic turn resolution

## 5. Core domain models
Suggested models:
- `DieModel`
  - id
  - value
  - assignedAction
- `ActionType`
  - attack
  - block
  - heal
- `PlayerState`
  - hp
  - maxHp
  - attackBonus
  - blockBonus
  - healBonus
  - shield
- `EnemyState`
  - type
  - hp
  - maxHp
  - intentIndex
  - currentIntentDamage
- `RewardType`
  - sharpEdge
  - ironSkin
  - fieldMedicine
  - vitality
- `RunState`
  - battlesCleared
  - player
  - status
  - tutorialSeen

## 6. Deterministic game logic
All core battle math must be implemented in pure Dart functions.

Recommended pure logic files:
- `turn_resolver.dart`
- `enemy_factory.dart`
- `reward_service.dart`

This matters because:
- easier testing
- easier debugging with AI
- fewer hidden UI bugs
- easier future refactors

## 7. Persistence
Use `shared_preferences` only for:
- `best_streak`
- `tutorial_seen`

Do not store mid-run state in MVP.

Recommended keys:
```text
best_streak
tutorial_seen
```

## 8. UI implementation notes
### Home screen
- Start Run button
- Best streak display
- Optional brief text: “3 dice. Attack. Block. Heal.”

### Battle screen
Keep the interaction simple.
Two acceptable UI choices:
1. tap a die, then choose action
2. tap a die repeatedly to cycle Attack -> Block -> Heal

Choose the simpler implementation and keep it readable.

Recommended display:
- top: enemy card
- middle: dice row
- lower middle: action assignment summary
- bottom: resolve button

### Reward screen
- 3 large cards
- one-line effect summary
- tap to confirm
- apply immediately and move to next battle

### Results screens
- Show battles cleared
- Show best streak
- CTA to start a new run

## 9. Orientation and device behavior
- Lock portrait orientation
- Support common phone sizes
- No tablet-specific UI work for MVP

## 10. Approved dependencies
Required:
```bash
flutter pub add shared_preferences
```

Not approved for MVP:
- Riverpod
- Bloc
- Firebase
- sqlite
- Flame
- audio packages

## 11. Installation and environment setup

## Tooling and stack setup for this project

### Mandatory stack
- **Target platform:** Android only
- **App framework:** Flutter
- **Language:** Dart
- **IDE:** Android Studio
- **AI agents:** Claude Code and Codex CLI
- **Persistence:** `shared_preferences`
- **Backend:** none
- **Networking:** none

### 1. Install Android Studio
1. Download and install Android Studio.
2. Open it once and let the setup wizard install the Android SDK.
3. In Android Studio, install the Flutter plugin:
   - macOS menu bar -> Android Studio -> Settings
   - Plugins -> Marketplace
   - search for `flutter`
   - install it
   - accept Dart plugin installation
   - restart Android Studio

### 2. Install Xcode command-line tools on the Mac
Run:
```bash
xcode-select --install
```

### 3. Install Flutter SDK
1. Download the current stable Flutter SDK.
2. Extract it somewhere simple, for example:
```bash
$HOME/develop/flutter
```
3. Add Flutter to your `PATH` in `~/.zprofile`:
```bash
echo 'export PATH="$HOME/develop/flutter/bin:$PATH"' >> ~/.zprofile
```
4. Open a new terminal window and verify:
```bash
flutter --version
dart --version
```

### 4. Finish Android SDK setup for Flutter
Open Android Studio -> SDK Manager and verify:
- API Level 36 platform is installed
- Android SDK Build-Tools
- Android SDK Command-line Tools
- Android Emulator
- Android SDK Platform-Tools
- CMake
- NDK (Side by side)

Then accept licenses and validate setup:
```bash
flutter doctor --android-licenses
flutter doctor
flutter emulators
flutter devices
```

### 5. Prefer a physical Android device if your Mac struggles
If the emulator feels heavy, use a physical Android phone with USB debugging enabled. That is a valid Flutter workflow and often much smoother on a laptop with limited RAM.

### 6. Install Claude Code
Anthropic currently recommends the native install path:
```bash
curl -fsSL https://claude.ai/install.sh | bash
claude
```

Alternative if you already use Homebrew:
```bash
brew install --cask claude-code
claude
```

### 7. Install Codex CLI
Codex CLI needs `npm`, so install Node.js first if you do not already have it.

Then install Codex:
```bash
npm i -g @openai/codex
codex
```

### 8. Connect Flutter tools to Claude Code and Codex with MCP
The Dart and Flutter MCP server is optional but strongly recommended.

For Claude Code, from the project folder:
```bash
claude mcp add --transport stdio dart -- dart mcp-server
```

For Codex, from the project folder:
```bash
codex mcp add dart -- dart mcp-server --force-roots-fallback
```

### 9. Create the Flutter project inside `/app`
From this game folder:
```bash
flutter create app --platforms=android --org com.example.offlinegames
cd app
flutter pub add shared_preferences
```

If this game uses Flame, add Flame after project creation:
```bash
flutter pub add flame
```

### 10. Basic validation commands
Always run these after each milestone:
```bash
cd app
flutter analyze
flutter test
flutter run
```


For this project, after app creation:
```bash
cd app
flutter pub add shared_preferences
```

## 12. Build and run commands
From the game folder:
```bash
flutter create app --platforms=android --org com.example.offlinegames
cd app
flutter pub add shared_preferences
flutter analyze
flutter test
flutter run
```

## 13. Testing strategy
### Unit tests
Required:
- turn resolution with mixed dice assignments
- shield absorption
- heal cap at max HP
- reward application
- enemy scaling by tier

### Widget tests
Required:
- battle screen renders current HP and intent
- reward screen renders 3 options
- home screen shows best streak

Minimum target: tests for rules first, UI smoke tests second.

## 14. Milestone implementation order
1. App shell and navigation
2. Pure battle rule engine
3. Battle screen interaction
4. Reward flow
5. Results screens and persistence
6. Testing cleanup and polish

## 15. Refusal list for the agent
Do not add:
- backend
- user accounts
- analytics
- ads
- audio pipeline
- achievements
- daily quests
- content pipelines
- inventory systems


## Official references used for setup sections
- Flutter install overview: https://docs.flutter.dev/install
- Flutter Android setup: https://docs.flutter.dev/platform-integration/android/setup
- Flutter Android Studio plugin setup: https://docs.flutter.dev/tools/android-studio
- Flutter add to PATH: https://docs.flutter.dev/install/add-to-path
- Flutter manual install: https://docs.flutter.dev/install/manual
- Flutter Dart and Flutter MCP server: https://docs.flutter.dev/ai/mcp-server
- Android Studio install: https://developer.android.com/studio/install
- Claude Code quickstart: https://code.claude.com/docs/en/quickstart
- Claude Code advanced setup: https://code.claude.com/docs/en/setup
- Codex CLI: https://developers.openai.com/codex/cli
- Codex MCP: https://developers.openai.com/codex/mcp
- Flutter persistence cookbook: https://docs.flutter.dev/cookbook/persistence/key-value
