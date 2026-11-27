import 'package:shared_preferences/shared_preferences.dart';

class SaveService {
  const SaveService();

  static const bestStreakKey = 'best_streak';
  static const tutorialSeenKey = 'tutorial_seen';

  Future<int> loadBestStreak() async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getInt(bestStreakKey) ?? 0;
  }

  Future<bool> loadTutorialSeen() async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getBool(tutorialSeenKey) ?? false;
  }

  Future<void> saveBestStreak(int battlesCleared) async {
    final preferences = await SharedPreferences.getInstance();
    final currentBest = preferences.getInt(bestStreakKey) ?? 0;

    if (battlesCleared <= currentBest) {
      return;
    }

    await preferences.setInt(bestStreakKey, battlesCleared);
  }

  Future<void> saveTutorialSeen(bool value) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setBool(tutorialSeenKey, value);
  }
}
