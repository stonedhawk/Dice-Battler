import 'package:dice_battler/app/ftue_truth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late List<String> printedLines;
  late DebugPrintCallback originalDebugPrint;

  setUp(() {
    FtueTruth.resetForTest();
    printedLines = [];
    originalDebugPrint = debugPrint;
    debugPrint = (String? message, {int? wrapWidth}) {
      if (message != null) {
        printedLines.add(message);
      }
    };
  });

  tearDown(() {
    debugPrint = originalDebugPrint;
    FtueTruth.resetForTest();
  });

  test('prints one FTUE_TRUTH line with the step id', () {
    FtueTruth.report(FtueStep.home);
    FtueTruth.report(FtueStep.gameOver);

    expect(printedLines, [
      'FTUE_TRUTH step=home',
      'FTUE_TRUTH step=game_over',
    ]);
  });

  test('skips a step that repeats the last one', () {
    FtueTruth.report(FtueStep.battle);
    FtueTruth.report(FtueStep.battle);
    FtueTruth.report(FtueStep.reward);
    FtueTruth.report(FtueStep.battle);

    expect(printedLines, [
      'FTUE_TRUTH step=battle',
      'FTUE_TRUTH step=reward',
      'FTUE_TRUTH step=battle',
    ]);
  });

  test('prints nothing when not in debug mode', () {
    FtueTruth.report(FtueStep.home, isDebugMode: false);
    FtueTruth.report(FtueStep.tutorial, isDebugMode: false);

    expect(printedLines, isEmpty);
  });

  test('every step id is lowercase snake_case', () {
    for (final step in FtueStep.values) {
      expect(step.id, matches(RegExp(r'^[a-z]+(_[a-z]+)*$')));
    }
  });
}
