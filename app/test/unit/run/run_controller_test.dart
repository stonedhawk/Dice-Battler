import 'package:dice_battler/features/battle/battle_controller.dart';
import 'package:dice_battler/features/battle/battle_models.dart';
import 'package:dice_battler/features/rewards/reward_models.dart';
import 'package:dice_battler/features/run/run_controller.dart';
import 'package:dice_battler/features/run/run_state.dart';
import 'package:dice_battler/features/storage/save_service.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeSaveService extends SaveService {
  const _FakeSaveService({
    this.bestStreak = 0,
    this.tutorialSeen = false,
  });

  final int bestStreak;
  final bool tutorialSeen;

  @override
  Future<int> loadBestStreak() async => bestStreak;

  @override
  Future<bool> loadTutorialSeen() async => tutorialSeen;

  @override
  Future<void> saveBestStreak(int battlesCleared) async {
    if (battlesCleared > _memoryBestStreak) {
      _memoryBestStreak = battlesCleared;
    }
  }

  @override
  Future<void> saveTutorialSeen(bool value) async {
    _memoryTutorialSeen = value;
  }

  static int _memoryBestStreak = 0;
  static bool _memoryTutorialSeen = false;

  static void resetMemory() {
    _memoryBestStreak = 0;
    _memoryTutorialSeen = false;
  }

  _FakeSaveService copyWithMemory() {
    return _FakeSaveService(
      bestStreak: _memoryBestStreak,
      tutorialSeen: _memoryTutorialSeen,
    );
  }
}

void main() {
  setUp(() {
    _FakeSaveService.resetMemory();
  });

  test('winning a battle moves the run to reward selection and next battle', () async {
    final controller = RunController(
      saveService: const _FakeSaveService(),
      battleControllerFactory: ({
        required int battleNumber,
        required PlayerState player,
      }) {
        return BattleController(
          battleNumber: battleNumber,
          initialPlayer: player,
          initialEnemy: const EnemyState(
            type: EnemyType.striker,
            hp: 3,
            maxHp: 3,
            intentPattern: [6, 8, 6],
            intentIndex: 0,
          ),
          initialDice: const [
            DieModel(id: 'die-1', value: 1, assignedAction: ActionType.attack),
            DieModel(id: 'die-2', value: 1, assignedAction: ActionType.attack),
            DieModel(id: 'die-3', value: 1, assignedAction: ActionType.attack),
          ],
        );
      },
    );
    await controller.persistenceReady;

    controller.battleController.resolveCurrentTurn();
    await controller.continueFromBattleResult();

    expect(controller.stage, RunStage.reward);
    expect(controller.state.battlesCleared, 1);
    expect(controller.rewardChoices, hasLength(3));

    controller.selectReward(RewardType.sharpEdge);

    expect(controller.stage, RunStage.battle);
    expect(controller.state.currentBattleNumber, 2);
    expect(controller.state.player.attackBonus, 1);
  });

  test('losing a battle moves the run to the game over screen', () async {
    final controller = RunController(
      saveService: const _FakeSaveService(bestStreak: 2),
      battleControllerFactory: ({
        required int battleNumber,
        required PlayerState player,
      }) {
        return BattleController(
          battleNumber: battleNumber,
          initialPlayer: const PlayerState(
            hp: 4,
            maxHp: 30,
            attackBonus: 0,
            blockBonus: 0,
            healBonus: 0,
            shield: 0,
          ),
          initialEnemy: const EnemyState(
            type: EnemyType.brute,
            hp: 30,
            maxHp: 30,
            intentPattern: [10, 10, 10],
            intentIndex: 0,
          ),
          initialDice: const [
            DieModel(id: 'die-1', value: 1, assignedAction: ActionType.heal),
            DieModel(id: 'die-2', value: 1, assignedAction: ActionType.heal),
            DieModel(id: 'die-3', value: 1, assignedAction: ActionType.heal),
          ],
        );
      },
    );
    await controller.persistenceReady;

    controller.battleController.resolveCurrentTurn();
    await controller.continueFromBattleResult();

    expect(controller.stage, RunStage.gameOver);
    expect(controller.state.status, RunStatus.defeat);
    expect(controller.bestStreak, 2);
  });

  test('markTutorialSeen updates controller state', () async {
    final controller = RunController(
      saveService: const _FakeSaveService(tutorialSeen: false),
    );
    await controller.persistenceReady;

    expect(controller.state.tutorialSeen, isFalse);

    await controller.markTutorialSeen();

    expect(controller.state.tutorialSeen, isTrue);
  });

  test('battle 10 victory skips rewards and records a new best streak', () async {
    const saveService = _FakeSaveService(bestStreak: 6);
    final controller = RunController(
      saveService: saveService,
      battleControllerFactory: ({
        required int battleNumber,
        required PlayerState player,
      }) {
        return BattleController(
          battleNumber: battleNumber,
          initialPlayer: player,
          initialEnemy: const EnemyState(
            type: EnemyType.brute,
            hp: 3,
            maxHp: 3,
            intentPattern: [4, 10, 4],
            intentIndex: 0,
          ),
          initialDice: const [
            DieModel(id: 'die-1', value: 1, assignedAction: ActionType.attack),
            DieModel(id: 'die-2', value: 1, assignedAction: ActionType.attack),
            DieModel(id: 'die-3', value: 1, assignedAction: ActionType.attack),
          ],
        );
      },
    );
    await controller.persistenceReady;

    for (var wins = 0; wins < 9; wins += 1) {
      controller.battleController.resolveCurrentTurn();
      await controller.continueFromBattleResult();
      controller.selectReward(RewardType.sharpEdge);
    }

    controller.battleController.resolveCurrentTurn();
    await controller.continueFromBattleResult();

    expect(controller.stage, RunStage.victory);
    expect(controller.state.status, RunStatus.victory);
    expect(controller.state.battlesCleared, 10);
    expect(controller.rewardChoices, isEmpty);
    expect(controller.bestStreak, 10);
    expect(controller.isNewBestThisRun, isTrue);
  });

  test('best streak can be loaded by a later controller after saving', () async {
    final firstSaveService = const _FakeSaveService(bestStreak: 0);
    final firstController = RunController(
      saveService: firstSaveService,
      battleControllerFactory: ({
        required int battleNumber,
        required PlayerState player,
      }) {
        return BattleController(
          battleNumber: battleNumber,
          initialPlayer: battleNumber == 5
              ? const PlayerState(
                  hp: 4,
                  maxHp: 30,
                  attackBonus: 0,
                  blockBonus: 0,
                  healBonus: 0,
                  shield: 0,
                )
              : player,
          initialEnemy: battleNumber == 5
              ? const EnemyState(
                  type: EnemyType.brute,
                  hp: 30,
                  maxHp: 30,
                  intentPattern: [10, 10, 10],
                  intentIndex: 0,
                )
              : const EnemyState(
                  type: EnemyType.striker,
                  hp: 3,
                  maxHp: 3,
                  intentPattern: [6, 8, 6],
                  intentIndex: 0,
                ),
          initialDice: battleNumber == 5
              ? const [
                  DieModel(id: 'die-1', value: 1, assignedAction: ActionType.heal),
                  DieModel(id: 'die-2', value: 1, assignedAction: ActionType.heal),
                  DieModel(id: 'die-3', value: 1, assignedAction: ActionType.heal),
                ]
              : const [
                  DieModel(id: 'die-1', value: 1, assignedAction: ActionType.attack),
                  DieModel(id: 'die-2', value: 1, assignedAction: ActionType.attack),
                  DieModel(id: 'die-3', value: 1, assignedAction: ActionType.attack),
                ],
        );
      },
    );
    await firstController.persistenceReady;

    for (var wins = 0; wins < 4; wins += 1) {
      firstController.battleController.resolveCurrentTurn();
      await firstController.continueFromBattleResult();
      firstController.selectReward(RewardType.sharpEdge);
    }

    firstController.battleController.resolveCurrentTurn();
    await firstController.continueFromBattleResult();

    final secondController = RunController(
      saveService: firstSaveService.copyWithMemory(),
    );
    await secondController.persistenceReady;

    expect(secondController.bestStreak, 4);
  });
}
