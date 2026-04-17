import 'package:flutter/material.dart';

class VictoryScreen extends StatelessWidget {
  const VictoryScreen({
    super.key,
    required this.battlesCleared,
    required this.bestStreak,
    required this.isNewBest,
    required this.onStartNewRun,
  });

  final int battlesCleared;
  final int bestStreak;
  final bool isNewBest;
  final VoidCallback onStartNewRun;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Victory')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You cleared the full run.',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 12),
                    Text('Battles cleared: $battlesCleared'),
                    const SizedBox(height: 8),
                    Text('Best streak: $bestStreak'),
                    if (isNewBest) ...[
                      const SizedBox(height: 8),
                      const Text('New best streak set this run.'),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: onStartNewRun,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text('Start New Run'),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
