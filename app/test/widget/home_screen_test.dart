import 'package:dice_battler/features/home/home_screen.dart';
import 'package:dice_battler/features/storage/save_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeSaveService extends SaveService {
  const _FakeSaveService({
    this.bestStreak = 0,
  });

  final int bestStreak;

  @override
  Future<int> loadBestStreak() async => bestStreak;
}

void main() {
  testWidgets('shows the home shell, best streak, and Start Run button', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(
          saveService: _FakeSaveService(bestStreak: 7),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Dice Battler'), findsOneWidget);
    expect(find.text('Best streak: 7'), findsOneWidget);
    expect(find.text('Start Run'), findsOneWidget);
  });
}
