import 'package:dice_battler/features/battle/battle_models.dart';
import 'package:dice_battler/features/rewards/reward_models.dart';
import 'package:dice_battler/features/rewards/reward_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('buildRewardChoices returns 3 unique deterministic rewards', () {
    final choices = RewardService.buildRewardChoices(battleNumber: 2);

    expect(choices, hasLength(3));
    expect(choices.toSet(), hasLength(3));
    expect(
      choices,
      equals([
        RewardType.ironSkin,
        RewardType.fieldMedicine,
        RewardType.vitality,
      ]),
    );
  });

  test('applyReward updates vitality immediately and caps healing at max hp', () {
    const player = PlayerState(
      hp: 29,
      maxHp: 30,
      attackBonus: 0,
      blockBonus: 0,
      healBonus: 0,
      shield: 3,
    );

    final updatedPlayer = RewardService.applyReward(
      player: player,
      reward: RewardType.vitality,
    );

    expect(updatedPlayer.maxHp, 34);
    expect(updatedPlayer.hp, 33);
    expect(updatedPlayer.shield, 0);
  });
}
