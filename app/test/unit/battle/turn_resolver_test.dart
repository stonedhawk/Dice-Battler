import 'package:dice_battler/features/battle/battle_models.dart';
import 'package:dice_battler/features/battle/turn_resolver.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('resolveTurn', () {
    test('applies mixed attack, block, and heal assignments in rule order', () {
      const player = PlayerState(
        hp: 20,
        maxHp: 30,
        attackBonus: 1,
        blockBonus: 0,
        healBonus: 1,
        shield: 0,
      );

      const enemy = EnemyState(
        type: EnemyType.striker,
        hp: 25,
        maxHp: 25,
        intentPattern: [8, 6, 8],
        intentIndex: 0,
      );

      final outcome = resolveTurn(
        player: player,
        enemy: enemy,
        dice: const [
          DieModel(id: 'd1', value: 6, assignedAction: ActionType.attack),
          DieModel(id: 'd2', value: 4, assignedAction: ActionType.block),
          DieModel(id: 'd3', value: 3, assignedAction: ActionType.heal),
        ],
      );

      expect(outcome.attackDamage, 7);
      expect(outcome.blockGained, 4);
      expect(outcome.healingGained, 3);
      expect(outcome.incomingDamage, 8);
      expect(outcome.unblockedDamage, 4);
      expect(outcome.enemy.hp, 18);
      expect(outcome.enemy.currentIntentDamage, 6);
      expect(outcome.player.hp, 19);
      expect(outcome.player.shield, 0);
      expect(outcome.enemyDefeated, isFalse);
      expect(outcome.playerDefeated, isFalse);
    });

    test('prevents the enemy from acting when attack damage defeats it', () {
      const player = PlayerState(
        hp: 18,
        maxHp: 30,
        attackBonus: 0,
        blockBonus: 0,
        healBonus: 0,
        shield: 0,
      );

      const enemy = EnemyState(
        type: EnemyType.trickster,
        hp: 10,
        maxHp: 10,
        intentPattern: [5, 5, 7],
        intentIndex: 0,
      );

      final outcome = resolveTurn(
        player: player,
        enemy: enemy,
        dice: const [
          DieModel(id: 'd1', value: 6, assignedAction: ActionType.attack),
          DieModel(id: 'd2', value: 4, assignedAction: ActionType.attack),
          DieModel(id: 'd3', value: 1, assignedAction: ActionType.heal),
        ],
      );

      expect(outcome.enemy.hp, 0);
      expect(outcome.incomingDamage, 0);
      expect(outcome.unblockedDamage, 0);
      expect(outcome.player.hp, 19);
      expect(outcome.enemyDefeated, isTrue);
      expect(outcome.playerDefeated, isFalse);
    });

    test('lets shield absorb incoming damage before hp is reduced', () {
      const player = PlayerState(
        hp: 21,
        maxHp: 30,
        attackBonus: 0,
        blockBonus: 0,
        healBonus: 0,
        shield: 2,
      );

      const enemy = EnemyState(
        type: EnemyType.brute,
        hp: 30,
        maxHp: 30,
        intentPattern: [6, 15, 6],
        intentIndex: 0,
      );

      final outcome = resolveTurn(
        player: player,
        enemy: enemy,
        dice: const [
          DieModel(id: 'd1', value: 5, assignedAction: ActionType.block),
          DieModel(id: 'd2', value: 1, assignedAction: ActionType.heal),
          DieModel(id: 'd3', value: 2, assignedAction: ActionType.heal),
        ],
      );

      expect(outcome.blockGained, 5);
      expect(outcome.incomingDamage, 6);
      expect(outcome.unblockedDamage, 0);
      expect(outcome.player.hp, 23);
      expect(outcome.player.shield, 0);
    });

    test("caps healing at the player's max HP", () {
      const player = PlayerState(
        hp: 25,
        maxHp: 30,
        attackBonus: 0,
        blockBonus: 0,
        healBonus: 1,
        shield: 0,
      );

      const enemy = EnemyState(
        type: EnemyType.striker,
        hp: 22,
        maxHp: 22,
        intentPattern: [0],
        intentIndex: 0,
      );

      final outcome = resolveTurn(
        player: player,
        enemy: enemy,
        dice: const [
          DieModel(id: 'd1', value: 6, assignedAction: ActionType.heal),
          DieModel(id: 'd2', value: 5, assignedAction: ActionType.heal),
          DieModel(id: 'd3', value: 1, assignedAction: ActionType.heal),
        ],
      );

      expect(outcome.healingGained, 10);
      expect(outcome.player.hp, 30);
      expect(outcome.unblockedDamage, 0);
    });
  });
}
