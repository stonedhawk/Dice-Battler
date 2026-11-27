import 'package:flutter/foundation.dart';

import '../battle/battle_controller.dart';
import '../battle/battle_models.dart';
import '../rewards/reward_models.dart';
import '../rewards/reward_service.dart';
import '../storage/save_service.dart';
import 'run_state.dart';

enum RunStage {
  battle,
  reward,
  victory,
  gameOver,
}

typedef BattleControllerFactory = BattleController Function({
  required int battleNumber,
  required PlayerState player,
});

class RunController extends ChangeNotifier {
  RunController({
    BattleControllerFactory? battleControllerFactory,
    SaveService saveService = const SaveService(),
  })  : _battleControllerFactory =
            battleControllerFactory ?? _defaultBattleControllerFactory,
        _saveService = saveService {
    _startNewRun();
    _persistenceReady = _loadPersistence();
  }

  static const PlayerState _startingPlayer = PlayerState(
    hp: 30,
    maxHp: 30,
    attackBonus: 0,
    blockBonus: 0,
    healBonus: 0,
    shield: 0,
  );

  final BattleControllerFactory _battleControllerFactory;
  final SaveService _saveService;

  late RunState _state;
  late RunStage _stage;
  late BattleController _battleController;
  late Future<void> _persistenceReady;
  List<RewardType> _rewardChoices = const [];
  int _bestStreak = 0;
  bool _tutorialSeen = false;
  bool _isNewBestThisRun = false;

  RunState get state => _state;
  RunStage get stage => _stage;
  BattleController get battleController => _battleController;
  List<RewardType> get rewardChoices =>
      List<RewardType>.unmodifiable(_rewardChoices);
  int get bestStreak => _bestStreak;
  bool get isNewBestThisRun => _isNewBestThisRun;
  Future<void> get persistenceReady => _persistenceReady;

  Future<void> continueFromBattleResult() async {
    await _persistenceReady;

    switch (_battleController.status) {
      case BattleStatus.inProgress:
        return;
      case BattleStatus.won:
        await _completeBattleVictory();
        return;
      case BattleStatus.lost:
        await _completeBattleDefeat();
        return;
    }
  }

  Future<void> markTutorialSeen() async {
    if (_tutorialSeen) {
      return;
    }

    _tutorialSeen = true;
    _state = _state.copyWith(tutorialSeen: true);
    notifyListeners();
    await _saveService.saveTutorialSeen(true);
  }

  void selectReward(RewardType reward) {
    final updatedPlayer = RewardService.applyReward(
      player: _state.player,
      reward: reward,
    );

    _state = _state.copyWith(player: _resetShield(updatedPlayer));
    _rewardChoices = const [];
    _stage = RunStage.battle;
    _battleController = _buildBattleController(
      battleNumber: _state.currentBattleNumber,
      player: _state.player,
    );
    notifyListeners();
  }

  void restartRun() {
    _startNewRun();
    notifyListeners();
  }

  void _startNewRun() {
    _state = RunState(
      battlesCleared: 0,
      currentBattleNumber: 1,
      player: _startingPlayer,
      status: RunStatus.inProgress,
      tutorialSeen: _tutorialSeen,
    );
    _stage = RunStage.battle;
    _rewardChoices = const [];
    _isNewBestThisRun = false;
    _battleController = _buildBattleController(
      battleNumber: _state.currentBattleNumber,
      player: _state.player,
    );
  }

  Future<void> _completeBattleVictory() async {
    final survivingPlayer = _resetShield(_battleController.player);
    final updatedBattlesCleared = _state.battlesCleared + 1;

    if (updatedBattlesCleared >= 10) {
      await _recordBestStreak(updatedBattlesCleared);
      _state = _state.copyWith(
        battlesCleared: updatedBattlesCleared,
        currentBattleNumber: updatedBattlesCleared,
        player: survivingPlayer,
        status: RunStatus.victory,
      );
      _stage = RunStage.victory;
      notifyListeners();
      return;
    }

    _state = _state.copyWith(
      battlesCleared: updatedBattlesCleared,
      currentBattleNumber: updatedBattlesCleared + 1,
      player: survivingPlayer,
      status: RunStatus.inProgress,
    );
    _rewardChoices = RewardService.buildRewardChoices(
      battleNumber: updatedBattlesCleared,
    );
    _stage = RunStage.reward;
    notifyListeners();
  }

  Future<void> _completeBattleDefeat() async {
    await _recordBestStreak(_state.battlesCleared);
    _state = _state.copyWith(
      player: _resetShield(_battleController.player),
      status: RunStatus.defeat,
    );
    _stage = RunStage.gameOver;
    notifyListeners();
  }

  BattleController _buildBattleController({
    required int battleNumber,
    required PlayerState player,
  }) {
    return _battleControllerFactory(
      battleNumber: battleNumber,
      player: _resetShield(player),
    );
  }

  static BattleController _defaultBattleControllerFactory({
    required int battleNumber,
    required PlayerState player,
  }) {
    return BattleController(
      battleNumber: battleNumber,
      initialPlayer: player,
    );
  }

  static PlayerState _resetShield(PlayerState player) {
    return player.copyWith(shield: 0);
  }

  Future<void> _loadPersistence() async {
    _bestStreak = await _saveService.loadBestStreak();
    _tutorialSeen = await _saveService.loadTutorialSeen();
    _state = _state.copyWith(tutorialSeen: _tutorialSeen);
    notifyListeners();
  }

  Future<void> _recordBestStreak(int battlesCleared) async {
    final previousBest = _bestStreak;

    await _saveService.saveBestStreak(battlesCleared);

    if (battlesCleared > previousBest) {
      _bestStreak = battlesCleared;
      _isNewBestThisRun = true;
      return;
    }

    _bestStreak = previousBest;
    _isNewBestThisRun = false;
  }
}
