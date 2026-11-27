import 'package:flutter/material.dart';

import 'reward_models.dart';
import 'reward_service.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({
    super.key,
    required this.battleNumber,
    required this.choices,
    required this.onRewardSelected,
  });

  final int battleNumber;
  final List<RewardType> choices;
  final ValueChanged<RewardType> onRewardSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose a reward')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'Battle $battleNumber cleared',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          const Text(
            'Pick 1 upgrade before the next fight. Rewards apply right away.',
          ),
          const SizedBox(height: 24),
          ...choices.map(
            (reward) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Card(
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () => onRewardSelected(reward),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4E0C9),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(Icons.auto_awesome),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                RewardService.titleFor(reward),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 6),
                              Text(RewardService.descriptionFor(reward)),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
