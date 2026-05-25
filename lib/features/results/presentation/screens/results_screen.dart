import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../game/presentation/providers/math_game_notifier.dart';
import '../../../game/presentation/screens/math_game_screen.dart';

class ResultsScreen extends ConsumerWidget {
  const ResultsScreen({
    super.key,
    required this.score,
    required this.xpEarned,
  });

  final int score;
  final int xpEarned;

  static const String routePath = '/results';
  static const String routeName = 'results';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.stars, size: 80, color: Colors.amber),
              const SizedBox(height: 24),
              Text(
                'Score: $score',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              Text(
                'XP Earned: +$xpEarned',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: cs.primary,
                    ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ref.read(mathGameNotifierProvider.notifier).reset();
                      context.go('/');
                    },
                    child: const Text('Home'),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () {
                      ref.read(mathGameNotifierProvider.notifier).reset();
                      context.go(MathGameScreen.routePath);
                    },
                    child: const Text('Play Again'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
