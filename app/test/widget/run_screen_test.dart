import 'package:dice_battler/features/battle/battle_controller.dart';
import 'package:dice_battler/features/battle/battle_models.dart';
import 'package:dice_battler/features/run/run_controller.dart';
import 'package:dice_battler/features/run/run_screen.dart';
import 'package:dice_battler/features/storage/save_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeSaveService extends SaveService {
  const _FakeSaveService({
    this.tutorialSeen = false,
  });

  final bool tutorialSeen;

  @override
  Future<int> loadBestStreak() async => 0;

  @override
  Future<bool> loadTutorialSeen() async => tutorialSeen;

  @override
  Future<void> saveBestStreak(int battlesCleared) async {}

  @override
  Future<void> saveTutorialSeen(bool value) async {}
}

void main() {
  testWidgets('a winning battle flows into rewards and then battle 2', (
    tester,
  ) async {
    final controller = RunController(
      saveService: const _FakeSaveService(tutorialSeen: true),
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
            intentPattern: const [6, 8, 6],
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

    await tester.pumpWidget(
      MaterialApp(
        home: RunScreen(
          controller: controller,
          showTutorialOnStart: false,
        ),
      ),
    );

    await tester.tap(find.text('Tap to pick').at(0));
    await tester.pump();
    await tester.tap(find.text('Tap to pick').at(0));
    await tester.pump();
    await tester.tap(find.text('Tap to pick').at(0));
    await tester.pump();

    await tester.scrollUntilVisible(
      find.byKey(const Key('resolve-turn-button')),
      300,
      scrollable: find.byType(Scrollable),
    );
    await tester.tap(find.byKey(const Key('resolve-turn-button')));
    await tester.pump();

    expect(find.text('Battle won'), findsOneWidget);

    await controller.continueFromBattleResult();
    await tester.pumpAndSettle();

    expect(find.text('Choose a reward'), findsOneWidget);
    expect(find.text('Battle 1 cleared'), findsOneWidget);

    await tester.tap(find.text('Sharp Edge'));
    await tester.pumpAndSettle();

    expect(find.text('Battle 2'), findsOneWidget);
  });

  testWidgets('tutorial dialog appears only when the flag is not saved', (
    tester,
  ) async {
    final controller = RunController(
      saveService: const _FakeSaveService(tutorialSeen: false),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: RunScreen(controller: controller),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('How turns work'), findsOneWidget);

    await tester.tap(find.text('Got it'));
    await tester.pumpAndSettle();

    expect(find.text('How turns work'), findsNothing);
    expect(controller.state.tutorialSeen, isTrue);
  });

  testWidgets('tutorial dialog stays hidden when the flag is already saved', (
    tester,
  ) async {
    final controller = RunController(
      saveService: const _FakeSaveService(tutorialSeen: true),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: RunScreen(controller: controller),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('How turns work'), findsNothing);
  });
}
