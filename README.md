# Dice Battler

A small, fully offline, turn-based dice combat game built with Flutter. Each turn you roll three dice and split them between attack, block and heal. Clear 10 battles to win the run.

- Platforms: Android and iOS, Android primary
- App id: `com.antigravity.dicebattler` on both platforms
- Portrait only
- The Flutter app lives in `app/`. The planning docs (`PRD.md`, `TECHNICAL_DESIGN.md`, `IMPLEMENTATION_PLAN.md`, `QA_CHECKLIST.md`) live at the root.

## Run it

```bash
cd app
flutter pub get
flutter analyze
flutter test
flutter run
```

## Debug builds

From `app/`:

```bash
flutter build apk --debug
flutter build ios --simulator --debug
```

| Platform | Output |
|---|---|
| Android | `app/build/app/outputs/flutter-apk/app-debug.apk` |
| iOS simulator | `app/build/ios/iphonesimulator/Runner.app` |

Install and launch, from the repo root:

```bash
adb -s emulator-5554 install -r app/build/app/outputs/flutter-apk/app-debug.apk
adb -s emulator-5554 shell am start -n com.antigravity.dicebattler/.MainActivity
xcrun simctl install booted app/build/ios/iphonesimulator/Runner.app
xcrun simctl launch booted com.antigravity.dicebattler
```

## FTUE truth log

Debug builds report the player's current screen to the device log, so tools such as ftue-friction-agent can use the game's own report as ground truth instead of hand labelling. Each time the screen changes, the game prints exactly one line:

```text
FTUE_TRUTH step=<id>
```

The same id is never printed twice in a row, and the first screen after launch is reported too. Release and profile builds print nothing. It is not analytics: nothing is stored or sent anywhere. The code is `app/lib/app/ftue_truth.dart`.

| Id | Screen |
|---|---|
| `home` | Home screen with the Start Run button. Reported at launch and again when you come back from a run. |
| `tutorial` | The "How turns work" dialog, shown on the first run until you tap Got it. |
| `battle` | A battle, including the "Battle won" or "Battle lost" card before you continue. |
| `reward` | Choose a reward, after battles 1 to 9. |
| `victory` | Victory, after battle 10. |
| `game_over` | Game Over, after a lost battle. |

On a first run the dialog opens over battle 1 while the page is still sliding in, so the log goes `home`, `tutorial`, `battle`; battle is not reported until the dialog closes. To see the tutorial again, clear the app's data (Android) or uninstall and reinstall it (iOS).

Read the lines on Android. Logcat shows them under the `flutter` tag, with the message exactly `FTUE_TRUTH step=<id>`:

```bash
adb -s emulator-5554 logcat -v epoch -s flutter | grep FTUE_TRUTH
```

Read the lines on the iOS simulator. Start the stream before you launch the app. Each event's `eventMessage` is `flutter: FTUE_TRUTH step=<id>` and its process is `Runner`:

```bash
xcrun simctl spawn booted log stream --style ndjson --predicate 'eventMessage CONTAINS "FTUE_TRUTH"'
```

To read them after the fact, use `log show`. Add `process == "Runner"`, because `log` also logs its own command line, which contains the predicate text. Every Flutter app's process is called `Runner`, so if another one is running, filter on the pid that `xcrun simctl launch` prints instead (`processIdentifier == <pid>`):

```bash
xcrun simctl spawn booted log show --last 10m --style ndjson --predicate 'process == "Runner" AND eventMessage CONTAINS "FTUE_TRUTH"'
```

If you add a screen the player can see, add its id to `FtueStep` and report it where the screen appears.
