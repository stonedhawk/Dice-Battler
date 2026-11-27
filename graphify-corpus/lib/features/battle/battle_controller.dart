import 'dart:math';

import 'package:flutter/foundation.dart';

import 'battle_models.dart';
import 'enemy_factory.dart';
import 'turn_resolver.dart';

enum BattleStatus {
  inProgress,
  won,
  lost,
}

class BattleController extends ChangeNotifier {
  BattleController({
    this.battleNumber = 1,
    Random? random,
    PlayerState? initialPlayer,
    EnemyState? initialEnemy,
    List<DieModel>? initialDice,
  })  : _random = random ?? Random(),
        _initialPlayer = initialPlayer ?? _startingPlayer,
        _initialEnemy = initialEnemy ??
            EnemyFactory.createEnemyForBattle(battleNumber),
        _initialDice = List<DieModel>.from(
          initialDice ?? _buildDice(random ?? Random()),
        ) {
    _resetBattle();
  }

  final int battleNumber;
  final Random _random;
  final PlayerState _initialPlayer;
  final EnemyState _initialEnemy;
  final List<DieModel> _initialDice;

  late PlayerState _player;
  late EnemyState _enemy;
  late List<DieModel> _dice;
  late BattleStatus _status;
  String _battleLog = 'Assign each die, then resolve the turn.';
  int _turnNumber = 1;

  static const PlayerState _startingPlayer = PlayerState(
    hp: 30,
    maxHp: 30,
    attackBonus: 0,
    blockBonus: 0,
    healBonus: 0,
    shield: 0,
  );

  PlayerState get player => _player;
  EnemyState get enemy => _enemy;
  List<DieModel> get dice => List<DieModel>.unmodifiable(_dice);
  BattleStatus get status => _status;
  String get battleLog => _battleLog;
  int get turnNumber => _turnNumber;

  bool get allDiceAssigned => _dice.every((die) => die.assignedAction != null);

  int get assignedAttackDice =>
      _dice.where((die) => die.assignedAction == ActionType.attack).length;

  int get assignedBlockDice =>
      _dice.where((die) => die.assignedAction == ActionType.block).length;

  int get assignedHealDice =>
      _dice.where((die) => die.assignedAction == ActionType.heal).length;

  void cycleDieAction(String dieId) {
    if (_status != BattleStatus.inProgress) {
      return;
    }

    _dice = _dice.map((die) {
      if (die.id != dieId) {
        return die;
      }

      return die.copyWith(
        assignedAction: _nextActionFor(die.assignedAction),
      );
    }).toList();

    notifyListeners();
  }

  void resolveCurrentTurn() {
    if (_status != BattleStatus.inProgress || !allDiceAssigned) {
      return;
    }

    final outcome = resolveTurn(
      player: _player,
      enemy: _enemy,
      dice: _dice,
    );

    _player = outcome.player;
    _enemy = outcome.enemy;

    if (outcome.enemyDefeated) {
      _status = BattleStatus.won;
      _battleLog =
          'Battle won on turn $_turnNumber. Dealt ${outcome.attackDamage} damage before the enemy could act.';
      notifyListeners();
      return;
    }

    if (outcome.playerDefeated) {
      _status = BattleStatus.lost;
      _battleLog =
          'Battle lost on turn $_turnNumber. Enemy hit for ${outcome.incomingDamage}, with ${outcome.unblockedDamage} getting through.';
      notifyListeners();
      return;
    }

    _turnNumber += 1;
    _dice = _buildDice(_random);
    _battleLog =
        'Turn ${_turnNumber - 1}: dealt ${outcome.attackDamage}, gained ${outcome.blockGained} shield, healed ${outcome.healingGained}, and took ${outcome.unblockedDamage}.';
    notifyListeners();
  }

  void restartBattle() {
    _resetBattle();
    notifyListeners();
  }

  void _resetBattle() {
    _player = _initialPlayer.copyWith();
    _enemy = _initialEnemy.copyWith(
      intentPattern: List<int>.from(_initialEnemy.intentPattern),
    );
    _dice = _copyDice(_initialDice);
    _status = BattleStatus.inProgress;
    _battleLog = 'Assign each die, then resolve the turn.';
    _turnNumber = 1;
  }

  ActionType _nextActionFor(ActionType? currentAction) {
    switch (currentAction) {
      case null:
        return ActionType.attack;
      case ActionType.attack:
        return ActionType.block;
      case ActionType.block:
        return ActionType.heal;
      case ActionType.heal:
        return ActionType.attack;
    }
  }

  static List<DieModel> _buildDice(Random random) {
    return List<DieModel>.generate(
      3,
      (index) => DieModel(
        id: 'die-${index + 1}',
        value: random.nextInt(6) + 1,
      ),
    );
  }

  static List<DieModel> _copyDice(List<DieModel> dice) {
    return dice
        .map(
          (die) => DieModel(
            id: die.id,
            value: die.value,
            assignedAction: die.assignedAction,
          ),
        )
        .toList();
  }
}
