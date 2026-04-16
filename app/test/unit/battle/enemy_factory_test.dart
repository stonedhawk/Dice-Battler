import 'package:dice_battler/features/battle/battle_models.dart';
import 'package:dice_battler/features/battle/enemy_factory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EnemyFactory', () {
    test('uses the fixed lineup for each battle number', () {
      expect(EnemyFactory.lineupTypeForBattle(1), EnemyType.striker);
      expect(EnemyFactory.lineupTypeForBattle(2), EnemyType.trickster);
      expect(EnemyFactory.lineupTypeForBattle(3), EnemyType.brute);
      expect(EnemyFactory.lineupTypeForBattle(10), EnemyType.brute);
    });

    test('creates tier 2 enemies with scaled hp and intent values', () {
      final enemy = EnemyFactory.createEnemyForBattle(4);

      expect(enemy.type, EnemyType.striker);
      expect(enemy.maxHp, 27);
      expect(enemy.hp, 27);
      expect(enemy.intentPattern, [7, 10, 7]);
      expect(enemy.currentIntentDamage, 7);
    });

    test('creates tier 3 enemies with scaled brute values', () {
      final enemy = EnemyFactory.createEnemyForBattle(8);

      expect(enemy.type, EnemyType.trickster);
      expect(enemy.maxHp, 39);
      expect(enemy.intentPattern, [7, 7, 10]);
    });

    test('reports the documented multipliers by battle range', () {
      expect(EnemyFactory.battleMultiplierForBattle(1), 1.0);
      expect(EnemyFactory.battleMultiplierForBattle(5), 1.25);
      expect(EnemyFactory.battleMultiplierForBattle(9), 1.5);
    });
  });
}
