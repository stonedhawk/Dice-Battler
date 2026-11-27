import '../battle/battle_models.dart';
import 'reward_models.dart';

class RewardService {
  const RewardService._();

  static const List<RewardType> rewardPool = [
    RewardType.sharpEdge,
    RewardType.ironSkin,
    RewardType.fieldMedicine,
    RewardType.vitality,
  ];

  static List<RewardType> buildRewardChoices({
    required int battleNumber,
  }) {
    if (battleNumber < 1 || battleNumber > 9) {
      throw RangeError.range(
        battleNumber,
        1,
        9,
        'battleNumber',
        'Rewards are only shown after battles 1 through 9.',
      );
    }

    final startIndex = (battleNumber - 1) % rewardPool.length;

    return List<RewardType>.generate(
      3,
      (index) => rewardPool[(startIndex + index) % rewardPool.length],
    );
  }

  static PlayerState applyReward({
    required PlayerState player,
    required RewardType reward,
  }) {
    switch (reward) {
      case RewardType.sharpEdge:
        return player.copyWith(attackBonus: player.attackBonus + 1, shield: 0);
      case RewardType.ironSkin:
        return player.copyWith(blockBonus: player.blockBonus + 1, shield: 0);
      case RewardType.fieldMedicine:
        return player.copyWith(healBonus: player.healBonus + 1, shield: 0);
      case RewardType.vitality:
        final updatedMaxHp = player.maxHp + 4;

        return player.copyWith(
          maxHp: updatedMaxHp,
          hp: (player.hp + 4).clamp(0, updatedMaxHp),
          shield: 0,
        );
    }
  }

  static String titleFor(RewardType reward) {
    switch (reward) {
      case RewardType.sharpEdge:
        return 'Sharp Edge';
      case RewardType.ironSkin:
        return 'Iron Skin';
      case RewardType.fieldMedicine:
        return 'Field Medicine';
      case RewardType.vitality:
        return 'Vitality';
    }
  }

  static String descriptionFor(RewardType reward) {
    switch (reward) {
      case RewardType.sharpEdge:
        return '+1 attack bonus';
      case RewardType.ironSkin:
        return '+1 block bonus';
      case RewardType.fieldMedicine:
        return '+1 heal bonus';
      case RewardType.vitality:
        return '+4 max HP and heal 4 immediately';
    }
  }
}
