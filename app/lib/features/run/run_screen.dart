import 'package:flutter/material.dart';

import '../battle/battle_screen.dart';
import '../home/tutorial_dialog.dart';
import '../results/game_over_screen.dart';
import '../results/victory_screen.dart';
import '../storage/save_service.dart';
import '../rewards/reward_screen.dart';
import 'run_controller.dart';

class RunScreen extends StatefulWidget {
  const RunScreen({
    super.key,
    this.controller,
    this.showTutorialOnStart = true,
  });

  final RunController? controller;
  final bool showTutorialOnStart;

  @override
  State<RunScreen> createState() => _RunScreenState();
}

class _RunScreenState extends State<RunScreen> {
  late final RunController _controller;
  late final bool _ownsController;
  bool _tutorialHandled = false;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ??
        RunController(
          saveService: const SaveService(),
        );
    if (widget.showTutorialOnStart) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _maybeShowTutorial();
      });
    }
  }

  @override
  void dispose() {
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
  }

  Future<void> _maybeShowTutorial() async {
    if (_tutorialHandled) {
      return;
    }

    _tutorialHandled = true;
    await _controller.persistenceReady;

    if (!mounted || _controller.state.tutorialSeen) {
      return;
    }

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const TutorialDialog(),
    );

    if (!mounted) {
      return;
    }

    await _controller.markTutorialSeen();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        switch (_controller.stage) {
          case RunStage.battle:
            return BattleScreen(
              controller: _controller.battleController,
              title: 'Battle ${_controller.state.currentBattleNumber}',
              showRestartControls: false,
              onContinueAfterWin: () {
                _controller.continueFromBattleResult();
              },
              onContinueAfterLoss: () {
                _controller.continueFromBattleResult();
              },
            );
          case RunStage.reward:
            return RewardScreen(
              battleNumber: _controller.state.battlesCleared,
              choices: _controller.rewardChoices,
              onRewardSelected: _controller.selectReward,
            );
          case RunStage.victory:
            return VictoryScreen(
              battlesCleared: _controller.state.battlesCleared,
              bestStreak: _controller.bestStreak,
              isNewBest: _controller.isNewBestThisRun,
              onStartNewRun: _controller.restartRun,
            );
          case RunStage.gameOver:
            return GameOverScreen(
              battlesCleared: _controller.state.battlesCleared,
              bestStreak: _controller.bestStreak,
              isNewBest: _controller.isNewBestThisRun,
              onStartNewRun: _controller.restartRun,
            );
        }
      },
    );
  }
}
