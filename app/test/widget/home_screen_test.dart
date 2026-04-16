import 'package:dice_battler/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the home shell and Start Run button', (tester) async {
    await tester.pumpWidget(const DiceBattlerApp());

    expect(find.text('Dice Battler'), findsOneWidget);
    expect(find.text('Start Run'), findsOneWidget);
  });
}
