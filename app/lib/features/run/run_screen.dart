import 'package:flutter/material.dart';

import '../../app/ftue_truth.dart';
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
  bool _isTutorialOpen = false;
  bool _canReportScreen = false;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ??
        RunController(
          saveService: const SaveService(),
        );
    _controller.addListener(_reportCurrentScreen);
    if (widget.showTutorialOnStart) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _maybeShowTutorial();
      });
    } else {
      _startReportingScreen();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_reportCurrentScreen);
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

    if (!mounted) {
      return;
    }

    if (_controller.state.tutorialSeen) {
      _startReportingScreen();
      return;
    }

    _isTutorialOpen = true;
    _startReportingScreen();

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const TutorialDialog(),
    );

    _isTutorialOpen = false;

    if (!mounted) {
      return;
    }

    _reportCurrentScreen();
    await _controller.markTutorialSeen();
  }

  // Screen reports wait until we know whether the tutorial opens, so the
  // FTUE truth log goes home, tutorial, battle without a battle flash first.
  void _startReportingScreen() {
    _canReportScreen = true;
    _reportCurrentScreen();
  }

  void _reportCurrentScreen() {
    if (!_canReportScreen) {
      return;
    }

    if (_isTutorialOpen) {
      FtueTruth.report(FtueStep.tutorial);
      return;
    }

    FtueTruth.report(_stepForStage(_controller.stage));
  }

  FtueStep _stepForStage(RunStage stage) {
    switch (stage) {
      case RunStage.battle:
        return FtueStep.battle;
      case RunStage.reward:
        return FtueStep.reward;
      case RunStage.victory:
        return FtueStep.victory;
      case RunStage.gameOver:
        return FtueStep.gameOver;
    }
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
