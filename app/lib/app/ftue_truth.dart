import 'package:flutter/foundation.dart';

/// The screens a player can see, as the ids the FTUE truth log uses.
enum FtueStep {
  home('home'),
  tutorial('tutorial'),
  battle('battle'),
  reward('reward'),
  victory('victory'),
  gameOver('game_over');

  const FtueStep(this.id);

  final String id;
}

/// Debug-only screen report for the ftue-friction-agent golden recordings.
///
/// Each time the player's screen changes, debug builds print one line such
/// as `FTUE_TRUTH step=battle` to the device log. The same step is never
/// printed twice in a row. Release and profile builds print nothing.
///
/// This is not analytics: nothing is stored or sent anywhere.
class FtueTruth {
  const FtueTruth._();

  static const linePrefix = 'FTUE_TRUTH step=';

  static FtueStep? _lastReportedStep;

  static void report(FtueStep step, {bool isDebugMode = kDebugMode}) {
    if (!isDebugMode) {
      return;
    }

    if (step == _lastReportedStep) {
      return;
    }

    _lastReportedStep = step;
    debugPrint('$linePrefix${step.id}');
  }

  @visibleForTesting
  static void resetForTest() {
    _lastReportedStep = null;
  }
}
