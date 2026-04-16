import 'dart:math' as math;

import 'battle_models.dart';

class TurnOutcome {
  const TurnOutcome({
    required this.player,
    required this.enemy,
    required this.attackDamage,
    required this.blockGained,
    required this.healingGained,
    required this.incomingDamage,
    required this.unblockedDamage,
    required this.enemyDefeated,
    required this.playerDefeated,
  });

  final PlayerState player;
  final EnemyState enemy;
  final int attackDamage;
  final int blockGained;
  final int healingGained;
  final int incomingDamage;
  final int unblockedDamage;
  final bool enemyDefeated;
  final bool playerDefeated;
}

TurnOutcome resolveTurn({
  required PlayerState player,
  required EnemyState enemy,
  required List<DieModel> dice,
}) {
  if (dice.isEmpty) {
    throw ArgumentError('At least one die is required to resolve a turn.');
  }

  final hasUnassignedDice = dice.any((die) => die.assignedAction == null);
  if (hasUnassignedDice) {
    throw StateError('Every die must be assigned before resolving a turn.');
  }

  final attackDamage = _sumAssignedDice(
    dice: dice,
    actionType: ActionType.attack,
    modifier: player.attackBonus,
  );
  final blockGained = _sumAssignedDice(
    dice: dice,
    actionType: ActionType.block,
    modifier: player.blockBonus,
  );
  final healingGained = dice
      .where((die) => die.assignedAction == ActionType.heal)
      .map((die) => ((die.value + 1) ~/ 2) + player.healBonus)
      .fold<int>(0, (sum, value) => sum + value);

  final enemyAfterAttack = enemy.copyWith(
    hp: math.max(0, enemy.hp - attackDamage),
  );

  final playerAfterBlock = player.copyWith(
    shield: player.shield + blockGained,
  );

  final playerAfterHeal = playerAfterBlock.copyWith(
    hp: math.min(player.maxHp, playerAfterBlock.hp + healingGained),
  );

  if (enemyAfterAttack.hp <= 0) {
    return TurnOutcome(
      player: playerAfterHeal,
      enemy: enemyAfterAttack,
      attackDamage: attackDamage,
      blockGained: blockGained,
      healingGained: healingGained,
      incomingDamage: 0,
      unblockedDamage: 0,
      enemyDefeated: true,
      playerDefeated: false,
    );
  }

  final incomingDamage = enemy.currentIntentDamage;
  final unblockedDamage = math.max(0, incomingDamage - playerAfterHeal.shield);
  final hpAfterDamage = math.max(0, playerAfterHeal.hp - unblockedDamage);
  final playerAfterEnemyTurn = playerAfterHeal.copyWith(
    hp: hpAfterDamage,
    shield: 0,
  );

  return TurnOutcome(
    player: playerAfterEnemyTurn,
    enemy: enemyAfterAttack.advanceIntent(),
    attackDamage: attackDamage,
    blockGained: blockGained,
    healingGained: healingGained,
    incomingDamage: incomingDamage,
    unblockedDamage: unblockedDamage,
    enemyDefeated: false,
    playerDefeated: hpAfterDamage <= 0,
  );
}

int _sumAssignedDice({
  required List<DieModel> dice,
  required ActionType actionType,
  required int modifier,
}) {
  return dice
      .where((die) => die.assignedAction == actionType)
      .map((die) => die.value + modifier)
      .fold<int>(0, (sum, value) => sum + value);
}
