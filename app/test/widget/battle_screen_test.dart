import 'package:dice_battler/features/battle/battle_controller.dart';
import 'package:dice_battler/features/battle/battle_models.dart';
import 'package:dice_battler/features/battle/battle_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('resolve button stays disabled until every die is assigned', (
    tester,
  ) async {
    final controller = BattleController(
      initialDice: const [
        DieModel(id: 'die-1', value: 2),
        DieModel(id: 'die-2', value: 4),
        DieModel(id: 'die-3', value: 6),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BattleScreen(controller: controller),
      ),
    );

    expect(controller.allDiceAssigned, isFalse);
    expect(controller.turnNumber, 1);

    await tester.scrollUntilVisible(
      find.text('Resolve Turn'),
      300,
      scrollable: find.byType(Scrollable),
    );
    await tester.pump();

    await tester.tap(find.text('Resolve Turn'));
    await tester.pump();

    expect(controller.turnNumber, 1);
    expect(find.text('Assign each die, then resolve the turn.'), findsOneWidget);

    await tester.tap(find.text('Tap to pick').at(0));
    await tester.pump();
    await tester.tap(find.text('Tap to pick').at(0));
    await tester.pump();
    await tester.tap(find.text('Tap to pick').at(0));
    await tester.pump();

    expect(controller.allDiceAssigned, isTrue);
  });

  testWidgets('player can win a single battle from the UI and restart', (
    tester,
  ) async {
    final controller = BattleController(
      initialEnemy: const EnemyState(
        type: EnemyType.striker,
        hp: 3,
        maxHp: 3,
        intentPattern: [6, 8, 6],
        intentIndex: 0,
      ),
      initialDice: const [
        DieModel(id: 'die-1', value: 1),
        DieModel(id: 'die-2', value: 1),
        DieModel(id: 'die-3', value: 1),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BattleScreen(controller: controller),
      ),
    );

    await tester.scrollUntilVisible(
      find.text('Resolve Turn'),
      300,
      scrollable: find.byType(Scrollable),
    );
    await tester.pump();

    await tester.tap(find.text('Tap to pick').at(0));
    await tester.pump();
    await tester.tap(find.text('Tap to pick').at(0));
    await tester.pump();
    await tester.tap(find.text('Tap to pick').at(0));
    await tester.pump();

    await tester.tap(find.text('Resolve Turn'));
    await tester.pump();

    expect(find.text('Battle won'), findsOneWidget);
    expect(find.textContaining('Battle won on turn 1'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Restart battle'),
      200,
      scrollable: find.byType(Scrollable),
    );
    await tester.pump();

    await tester.tap(find.text('Restart battle'));
    await tester.pump();

    expect(find.text('Last action summary'), findsOneWidget);
    expect(find.text('Assign each die, then resolve the turn.'), findsOneWidget);
  });
}
