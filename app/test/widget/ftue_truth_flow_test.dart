import 'package:dice_battler/app/app.dart';
import 'package:dice_battler/app/ftue_truth.dart';
import 'package:dice_battler/features/battle/battle_controller.dart';
import 'package:dice_battler/features/battle/battle_models.dart';
import 'package:dice_battler/features/run/run_controller.dart';
import 'package:dice_battler/features/run/run_screen.dart';
import 'package:dice_battler/features/storage/save_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeSaveService extends SaveService {
  const _FakeSaveService();

  @override
  Future<int> loadBestStreak() async => 0;

  @override
  Future<bool> loadTutorialSeen() async => true;

  @override
  Future<void> saveBestStreak(int battlesCleared) async {}

  @override
  Future<void> saveTutorialSeen(bool value) async {}
}

// Runs [body] while collecting the FTUE_TRUTH lines it prints. debugPrint is
// restored before the test ends, which flutter_test checks.
Future<List<String>> _captureTruthLines(Future<void> Function() body) async {
  final truthLines = <String>[];
  final originalDebugPrint = debugPrint;
  FtueTruth.resetForTest();
  debugPrint = (String? message, {int? wrapWidth}) {
    if (message != null && message.startsWith(FtueTruth.linePrefix)) {
      truthLines.add(message);
    }
  };

  try {
    await body();
  } finally {
    debugPrint = originalDebugPrint;
    FtueTruth.resetForTest();
  }

  return truthLines;
}

Future<void> _assignAllDiceAndResolve(WidgetTester tester) async {
  for (var dieIndex = 0; dieIndex < 3; dieIndex++) {
    await tester.tap(find.text('Tap to pick').at(0));
    await tester.pump();
  }

  await tester.scrollUntilVisible(
    find.byKey(const Key('resolve-turn-button')),
    300,
    scrollable: find.byType(Scrollable),
  );
  await tester.tap(find.byKey(const Key('resolve-turn-button')));
  await tester.pump();
}

void main() {
  testWidgets('a first session logs home, tutorial, battle, then home', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    final truthLines = await _captureTruthLines(() async {
      await tester.pumpWidget(const DiceBattlerApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Start Run'));
      await tester.pumpAndSettle();
      expect(find.text('How turns work'), findsOneWidget);

      await tester.tap(find.text('Got it'));
      await tester.pumpAndSettle();
      expect(find.text('Battle 1'), findsOneWidget);

      await tester.pageBack();
      await tester.pumpAndSettle();
    });

    expect(truthLines, [
      'FTUE_TRUTH step=home',
      'FTUE_TRUTH step=tutorial',
      'FTUE_TRUTH step=battle',
      'FTUE_TRUTH step=home',
    ]);
  });

  testWidgets('a win then a loss logs battle, reward, battle, game_over', (
    tester,
  ) async {
    final controller = RunController(
      saveService: const _FakeSaveService(),
      battleControllerFactory: ({
        required int battleNumber,
        required PlayerState player,
      }) {
        return BattleController(
          battleNumber: battleNumber,
          initialPlayer: player,
          initialEnemy: EnemyState(
            type: EnemyType.striker,
            hp: battleNumber == 1 ? 3 : 22,
            maxHp: battleNumber == 1 ? 3 : 22,
            intentPattern: const [100],
            intentIndex: 0,
          ),
          initialDice: const [
            DieModel(id: 'die-1', value: 1),
            DieModel(id: 'die-2', value: 1),
            DieModel(id: 'die-3', value: 1),
          ],
        );
      },
    );
    await controller.persistenceReady;

    final truthLines = await _captureTruthLines(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: RunScreen(
            controller: controller,
            showTutorialOnStart: false,
          ),
        ),
      );

      await _assignAllDiceAndResolve(tester);
      await controller.continueFromBattleResult();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Sharp Edge'));
      await tester.pumpAndSettle();

      await _assignAllDiceAndResolve(tester);
      expect(find.text('Battle lost'), findsOneWidget);
      await controller.continueFromBattleResult();
      await tester.pumpAndSettle();
    });

    expect(truthLines, [
      'FTUE_TRUTH step=battle',
      'FTUE_TRUTH step=reward',
      'FTUE_TRUTH step=battle',
      'FTUE_TRUTH step=game_over',
    ]);
  });
}
