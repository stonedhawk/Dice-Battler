enum ActionType {
  attack,
  block,
  heal,
}

enum EnemyType {
  striker,
  brute,
  trickster,
}

class DieModel {
  const DieModel({
    required this.id,
    required this.value,
    this.assignedAction,
  }) : assert(value >= 1 && value <= 6, 'Dice values must be between 1 and 6.');

  final String id;
  final int value;
  final ActionType? assignedAction;

  DieModel copyWith({
    String? id,
    int? value,
    ActionType? assignedAction,
    bool clearAssignedAction = false,
  }) {
    return DieModel(
      id: id ?? this.id,
      value: value ?? this.value,
      assignedAction: clearAssignedAction
          ? null
          : assignedAction ?? this.assignedAction,
    );
  }
}

class PlayerState {
  const PlayerState({
    required this.hp,
    required this.maxHp,
    required this.attackBonus,
    required this.blockBonus,
    required this.healBonus,
    required this.shield,
  }) : assert(maxHp > 0, 'Max HP must be positive.');

  final int hp;
  final int maxHp;
  final int attackBonus;
  final int blockBonus;
  final int healBonus;
  final int shield;

  PlayerState copyWith({
    int? hp,
    int? maxHp,
    int? attackBonus,
    int? blockBonus,
    int? healBonus,
    int? shield,
  }) {
    return PlayerState(
      hp: hp ?? this.hp,
      maxHp: maxHp ?? this.maxHp,
      attackBonus: attackBonus ?? this.attackBonus,
      blockBonus: blockBonus ?? this.blockBonus,
      healBonus: healBonus ?? this.healBonus,
      shield: shield ?? this.shield,
    );
  }
}

class EnemyState {
  const EnemyState({
    required this.type,
    required this.hp,
    required this.maxHp,
    required this.intentPattern,
    required this.intentIndex,
  });

  final EnemyType type;
  final int hp;
  final int maxHp;
  final List<int> intentPattern;
  final int intentIndex;

  int get currentIntentDamage => intentPattern[intentIndex];

  EnemyState copyWith({
    EnemyType? type,
    int? hp,
    int? maxHp,
    List<int>? intentPattern,
    int? intentIndex,
  }) {
    return EnemyState(
      type: type ?? this.type,
      hp: hp ?? this.hp,
      maxHp: maxHp ?? this.maxHp,
      intentPattern: intentPattern ?? this.intentPattern,
      intentIndex: intentIndex ?? this.intentIndex,
    );
  }

  EnemyState advanceIntent() {
    final nextIndex = (intentIndex + 1) % intentPattern.length;

    return copyWith(intentIndex: nextIndex);
  }
}
