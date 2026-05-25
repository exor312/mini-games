import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../profile/presentation/providers/progress_notifier.dart';
import '../providers/math_game_notifier.dart';
import '../providers/math_game_state.dart';
import '../widgets/answer_button.dart';

class MathGameScreen extends ConsumerStatefulWidget {
  const MathGameScreen({super.key});

  static const String routePath = '/game/math';
  static const String routeName = 'mathGame';

  @override
  ConsumerState<MathGameScreen> createState() => _MathGameScreenState();
}

class _MathGameScreenState extends ConsumerState<MathGameScreen> {
  Timer? _advanceTimer;

  @override
  void initState() {
    super.initState();
    // Reset game state when entering the screen to prevent stale state
    // from a previous completed game (e.g. user went Home then re-entered)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(mathGameNotifierProvider.notifier).reset();
    });
  }

  @override
  void dispose() {
    _advanceTimer?.cancel();
    super.dispose();
  }

  void _onAnswerSelected(int index) {
    final notifier = ref.read(mathGameNotifierProvider.notifier);
    final state = ref.read(mathGameNotifierProvider);

    if (state.showFeedback || state.isComplete) return;

    notifier.selectAnswer(index);

    _advanceTimer?.cancel();
    _advanceTimer = Timer(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      notifier.advance();
      final currentState = ref.read(mathGameNotifierProvider);
      if (currentState.isComplete) {
        _navigateToResults();
      }
    });
  }

  Future<void> _navigateToResults() async {
    final state = ref.read(mathGameNotifierProvider);
    final xpEarned = state.score * 10;

    // Award XP and increment streak
    await ref.read(progressNotifierProvider.notifier).addXP(xpEarned);
    await ref.read(progressNotifierProvider.notifier).incrementStreak();

    if (!mounted) return;
    context.go('/results', extra: {
      'score': state.score,
      'xpEarned': xpEarned,
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mathGameNotifierProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Math Game'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildHeader(state, cs),
            const SizedBox(height: 24),
            _buildQuestion(state, cs),
            const SizedBox(height: 24),
            _buildAnswerGrid(state, cs),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(MathGameState state, ColorScheme cs) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Question ${state.currentIndex + 1}/${MathGameNotifier.questionCount}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: cs.onSurface,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: cs.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            'Score: ${state.score}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: cs.onPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestion(MathGameState state, ColorScheme cs) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        state.currentQuestion.questionText,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: cs.onSurface,
        ),
      ),
    );
  }

  Widget _buildAnswerGrid(MathGameState state, cs) {
    final question = state.currentQuestion;

    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.5,
        children: List.generate(question.options.length, (index) {
          AnswerButtonState buttonState = AnswerButtonState.normal;
          if (state.showFeedback) {
            final thisValue = question.options[index];
            if (thisValue == question.correctAnswer) {
              buttonState = AnswerButtonState.correct;
            } else if (index == state.selectedAnswerIndex) {
              buttonState = AnswerButtonState.incorrect;
            }
          }

          return AnswerButton(
            value: question.options[index],
            state: buttonState,
            onTap: () => _onAnswerSelected(index),
          );
        }),
      ),
    );
  }
}
