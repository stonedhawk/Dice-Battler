import '../battle/battle_models.dart';

enum RunStatus {
  notStarted,
  inProgress,
  victory,
  defeat,
}

class RunState {
  const RunState({
    required this.battlesCleared,
    required this.currentBattleNumber,
    required this.player,
    required this.status,
    required this.tutorialSeen,
  });

  final int battlesCleared;
  final int currentBattleNumber;
  final PlayerState player;
  final RunStatus status;
  final bool tutorialSeen;

  RunState copyWith({
    int? battlesCleared,
    int? currentBattleNumber,
    PlayerState? player,
    RunStatus? status,
    bool? tutorialSeen,
  }) {
    return RunState(
      battlesCleared: battlesCleared ?? this.battlesCleared,
      currentBattleNumber: currentBattleNumber ?? this.currentBattleNumber,
      player: player ?? this.player,
      status: status ?? this.status,
      tutorialSeen: tutorialSeen ?? this.tutorialSeen,
    );
  }
}
