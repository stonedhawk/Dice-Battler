import 'package:dice_battler/features/storage/save_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  const saveService = SaveService();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('best streak loads as zero by default and only stores improvements', () async {
    expect(await saveService.loadBestStreak(), 0);

    await saveService.saveBestStreak(4);
    await saveService.saveBestStreak(2);

    expect(await saveService.loadBestStreak(), 4);
  });

  test('tutorial seen flag persists once saved', () async {
    expect(await saveService.loadTutorialSeen(), isFalse);

    await saveService.saveTutorialSeen(true);

    expect(await saveService.loadTutorialSeen(), isTrue);
  });
}
