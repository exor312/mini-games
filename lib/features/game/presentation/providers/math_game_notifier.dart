import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../game/domain/entities/math_question.dart';
import '../../../game/domain/utils/math_question_generator.dart';
import 'math_game_state.dart';

class MathGameNotifier extends StateNotifier<MathGameState> {
  MathGameNotifier() : super(MathGameState(questions: _generateQuestions()));

  static const int questionCount = 10;

  static List<MathQuestion> _generateQuestions() {
    return List.generate(questionCount, (_) => generateQuestion());
  }

  void selectAnswer(int index) {
    if (state.showFeedback) return;

    final isCorrect = state.currentQuestion.options[index] == state.currentQuestion.correctAnswer;
    final newScore = isCorrect ? state.score + 1 : state.score;

    state = state.copyWith(
      selectedAnswerIndex: index,
      showFeedback: true,
      score: newScore,
    );
  }

  void advance() {
    if (!state.showFeedback) return;

    final nextIndex = state.currentIndex + 1;
    if (nextIndex >= questionCount) {
      state = state.copyWith(
        selectedAnswerIndexNull: true,
        showFeedback: false,
        isComplete: true,
      );
    } else {
      state = state.copyWith(
        currentIndex: nextIndex,
        selectedAnswerIndexNull: true,
        showFeedback: false,
      );
    }
  }

  void reset() {
    state = MathGameState(questions: _generateQuestions());
  }
}

final mathGameNotifierProvider =
    StateNotifierProvider<MathGameNotifier, MathGameState>(
  (ref) => MathGameNotifier(),
);
