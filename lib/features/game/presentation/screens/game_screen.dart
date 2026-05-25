import 'package:flutter/material.dart';
import '../../../game/domain/entities/game_result.dart';
import 'math_game_screen.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key, required this.gameType});

  final GameType gameType;

  static const String routePath = '/game/:type';
  static const String routeName = 'game';

  @override
  Widget build(BuildContext context) {
    if (gameType == GameType.math) {
      return const MathGameScreen();
    }

    // Spelling and other games: placeholder
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(gameType.displayName),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              gameType == GameType.math ? Icons.calculate : Icons.abc,
              size: 80,
              color: cs.primary,
            ),
            const SizedBox(height: 24),
            Text(
              '${gameType.displayName} Game',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Coming Soon!',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
