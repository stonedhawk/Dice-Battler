import 'dart:math' as math;

import 'battle_models.dart';

const List<EnemyType> _battleLineup = [
  EnemyType.striker,
  EnemyType.trickster,
  EnemyType.brute,
  EnemyType.striker,
  EnemyType.trickster,
  EnemyType.brute,
  EnemyType.striker,
  EnemyType.trickster,
  EnemyType.brute,
  EnemyType.brute,
];

class EnemyFactory {
  const EnemyFactory._();

  static EnemyState createEnemyForBattle(int battleNumber) {
    if (battleNumber < 1 || battleNumber > _battleLineup.length) {
      throw RangeError.range(
        battleNumber,
        1,
        _battleLineup.length,
        'battleNumber',
        'Battle number must be between 1 and 10.',
      );
    }

    final enemyType = _battleLineup[battleNumber - 1];
    final multiplier = battleMultiplierForBattle(battleNumber);
    final definition = _definitionForType(enemyType);

    return EnemyState(
      type: enemyType,
      hp: _scaleValue(definition.baseHp, multiplier),
      maxHp: _scaleValue(definition.baseHp, multiplier),
      intentPattern: definition.intentPattern
          .map((value) => _scaleValue(value, multiplier))
          .toList(),
      intentIndex: 0,
    );
  }

  static double battleMultiplierForBattle(int battleNumber) {
    if (battleNumber >= 1 && battleNumber <= 3) {
      return 1.0;
    }

    if (battleNumber >= 4 && battleNumber <= 7) {
      return 1.25;
    }

    if (battleNumber >= 8 && battleNumber <= 10) {
      return 1.5;
    }

    throw RangeError.range(
      battleNumber,
      1,
      10,
      'battleNumber',
      'Battle number must be between 1 and 10.',
    );
  }

  static EnemyType lineupTypeForBattle(int battleNumber) {
    if (battleNumber < 1 || battleNumber > _battleLineup.length) {
      throw RangeError.range(
        battleNumber,
        1,
        _battleLineup.length,
        'battleNumber',
        'Battle number must be between 1 and 10.',
      );
    }

    return _battleLineup[battleNumber - 1];
  }

  static _EnemyDefinition _definitionForType(EnemyType type) {
    switch (type) {
      case EnemyType.striker:
        return const _EnemyDefinition(
          baseHp: 22,
          intentPattern: [6, 8, 6],
        );
      case EnemyType.brute:
        return const _EnemyDefinition(
          baseHp: 30,
          intentPattern: [4, 10, 4],
        );
      case EnemyType.trickster:
        return const _EnemyDefinition(
          baseHp: 26,
          intentPattern: [5, 5, 7],
        );
    }
  }

  static int _scaleValue(int baseValue, double multiplier) {
    return math.max(1, (baseValue * multiplier).floor());
  }
}

class _EnemyDefinition {
  const _EnemyDefinition({
    required this.baseHp,
    required this.intentPattern,
  });

  final int baseHp;
  final List<int> intentPattern;
}
