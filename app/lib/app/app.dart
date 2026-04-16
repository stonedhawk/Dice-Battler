import 'package:flutter/material.dart';

import '../features/battle/battle_screen.dart';
import '../features/home/home_screen.dart';
import 'routes.dart';
import 'theme.dart';

class DiceBattlerApp extends StatelessWidget {
  const DiceBattlerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice Battler',
      theme: buildAppTheme(),
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.battle: (context) => const BattleScreen(),
      },
    );
  }
}
