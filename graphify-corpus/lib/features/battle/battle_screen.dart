import 'package:flutter/material.dart';

import 'battle_controller.dart';
import 'battle_models.dart';

class BattleScreen extends StatefulWidget {
  const BattleScreen({
    super.key,
    this.controller,
    this.title = 'Battle 1',
    this.showRestartControls = true,
    this.onContinueAfterWin,
    this.onContinueAfterLoss,
  });

  final BattleController? controller;
  final String title;
  final bool showRestartControls;
  final VoidCallback? onContinueAfterWin;
  final VoidCallback? onContinueAfterLoss;

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  late final BattleController _controller;
  late final bool _ownsController;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? BattleController();
  }

  @override
  void dispose() {
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: widget.showRestartControls
            ? [
                TextButton(
                  onPressed: _controller.restartBattle,
                  child: const Text('Restart'),
                ),
              ]
            : null,
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              _CombatantCard(
                title: _enemyName(_controller.enemy.type),
                subtitle:
                    'Intent: ${_controller.enemy.currentIntentDamage} damage next turn',
                hpLabel:
                    'HP ${_controller.enemy.hp}/${_controller.enemy.maxHp}',
                accentColor: const Color(0xFF9B2C2C),
              ),
              const SizedBox(height: 16),
              _CombatantCard(
                title: 'Player',
                subtitle:
                    'Shield ${_controller.player.shield} • Turn ${_controller.turnNumber}',
                hpLabel:
                    'HP ${_controller.player.hp}/${_controller.player.maxHp}',
                accentColor: const Color(0xFF1F6F5F),
              ),
              const SizedBox(height: 24),
              Text(
                'Roll and assign dice',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: _controller.dice
                    .map(
                      (die) => _DieCard(
                        die: die,
                        onTap: () => _controller.cycleDieAction(die.id),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Assignment summary',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _SummaryChip(
                            label: 'Attack',
                            value: _controller.assignedAttackDice,
                            color: const Color(0xFFF6B0A7),
                          ),
                          _SummaryChip(
                            label: 'Block',
                            value: _controller.assignedBlockDice,
                            color: const Color(0xFFB5D9FF),
                          ),
                          _SummaryChip(
                            label: 'Heal',
                            value: _controller.assignedHealDice,
                            color: const Color(0xFFBEE7C6),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                key: const Key('resolve-turn-button'),
                onPressed: _controller.allDiceAssigned &&
                        _controller.status == BattleStatus.inProgress
                    ? _controller.resolveCurrentTurn
                    : null,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text('Resolve Turn'),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                color: _statusColor(_controller.status),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _statusTitle(_controller.status),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(_controller.battleLog),
                      if (_controller.status != BattleStatus.inProgress) ...[
                        const SizedBox(height: 12),
                        if (_controller.status == BattleStatus.won &&
                            widget.onContinueAfterWin != null)
                          FilledButton(
                            key: const Key('continue-after-win-button'),
                            onPressed: widget.onContinueAfterWin,
                            child: const Text('Continue'),
                          ),
                        if (_controller.status == BattleStatus.lost &&
                            widget.onContinueAfterLoss != null)
                          FilledButton(
                            key: const Key('continue-after-loss-button'),
                            onPressed: widget.onContinueAfterLoss,
                            child: const Text('See results'),
                          ),
                        if (widget.showRestartControls) ...[
                          if (_controller.status == BattleStatus.won &&
                              widget.onContinueAfterWin != null)
                            const SizedBox(height: 8),
                          if (_controller.status == BattleStatus.lost &&
                              widget.onContinueAfterLoss != null)
                            const SizedBox(height: 8),
                          OutlinedButton(
                            key: const Key('restart-battle-button'),
                            onPressed: _controller.restartBattle,
                            child: const Text('Restart battle'),
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _enemyName(EnemyType type) {
    switch (type) {
      case EnemyType.striker:
        return 'Striker';
      case EnemyType.brute:
        return 'Brute';
      case EnemyType.trickster:
        return 'Trickster';
    }
  }

  String _statusTitle(BattleStatus status) {
    switch (status) {
      case BattleStatus.inProgress:
        return 'Last action summary';
      case BattleStatus.won:
        return 'Battle won';
      case BattleStatus.lost:
        return 'Battle lost';
    }
  }

  Color _statusColor(BattleStatus status) {
    switch (status) {
      case BattleStatus.inProgress:
        return const Color(0xFFFFF7EA);
      case BattleStatus.won:
        return const Color(0xFFE6F6EA);
      case BattleStatus.lost:
        return const Color(0xFFFBE7E7);
    }
  }
}

class _CombatantCard extends StatelessWidget {
  const _CombatantCard({
    required this.title,
    required this.subtitle,
    required this.hpLabel,
    required this.accentColor,
  });

  final String title;
  final String subtitle;
  final String hpLabel;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text(subtitle),
                ],
              ),
            ),
            Text(
              hpLabel,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

class _DieCard extends StatelessWidget {
  const _DieCard({
    required this.die,
    required this.onTap,
  });

  final DieModel die;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final action = die.assignedAction;

    return SizedBox(
      width: 104,
      child: FilledButton.tonal(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: _backgroundColor(action),
          padding: const EdgeInsets.all(14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Column(
          children: [
            Text(
              '${die.value}',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _actionLabel(action),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String _actionLabel(ActionType? action) {
    switch (action) {
      case null:
        return 'Tap to pick';
      case ActionType.attack:
        return 'Attack';
      case ActionType.block:
        return 'Block';
      case ActionType.heal:
        return 'Heal';
    }
  }

  Color _backgroundColor(ActionType? action) {
    switch (action) {
      case null:
        return const Color(0xFFF4EDE4);
      case ActionType.attack:
        return const Color(0xFFF6B0A7);
      case ActionType.block:
        return const Color(0xFFB5D9FF);
      case ActionType.heal:
        return const Color(0xFFBEE7C6);
    }
  }
}

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '$label: $value',
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}
