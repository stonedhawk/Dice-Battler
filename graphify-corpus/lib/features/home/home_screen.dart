import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../storage/save_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.saveService = const SaveService(),
  });

  final SaveService saveService;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bestStreak = 0;

  @override
  void initState() {
    super.initState();
    _loadBestStreak();
  }

  Future<void> _loadBestStreak() async {
    final bestStreak = await widget.saveService.loadBestStreak();

    if (!mounted) {
      return;
    }

    setState(() {
      _bestStreak = bestStreak;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
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
                      const Text(
                        'Dice Battler',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'A tiny offline tactics run. Roll 3 dice, then split them between attack, block, and heal.',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Best streak: $_bestStreak',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () async {
                  await Navigator.of(context).pushNamed(AppRoutes.run);
                  await _loadBestStreak();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text('Start Run'),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Three dice. Attack. Block. Heal. Clear all 10 battles in one run.',
                textAlign: TextAlign.center,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
