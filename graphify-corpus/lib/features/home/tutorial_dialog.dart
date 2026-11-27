import 'package:flutter/material.dart';

class TutorialDialog extends StatelessWidget {
  const TutorialDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('How turns work'),
      content: const Text(
        'Each turn, 3 dice roll automatically. Tap each die to assign it to attack, block, or heal, then resolve the turn. Clear 10 battles to win the run.',
      ),
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Got it'),
        ),
      ],
    );
  }
}
