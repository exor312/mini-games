import 'package:equatable/equatable.dart';

import '../../../game/domain/entities/math_question.dart';

class MathGameState extends Equatable {
  const MathGameState({
    required this.questions,
    this.currentIndex = 0,
    this.score = 0,
    this.selectedAnswerIndex,
    this.showFeedback = false,
    this.isComplete = false,
  });

  final List<MathQuestion> questions;
  final int currentIndex;
  final int score;
  final int? selectedAnswerIndex;
  final bool showFeedback;
  final bool isComplete;

  MathQuestion get currentQuestion => questions[currentIndex];

  MathGameState copyWith({
    List<MathQuestion>? questions,
    int? currentIndex,
    int? score,
    int? selectedAnswerIndex,
    bool? selectedAnswerIndexNull,
    bool? showFeedback,
    bool? isComplete,
  }) {
    return MathGameState(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      score: score ?? this.score,
      selectedAnswerIndex: selectedAnswerIndexNull == true
          ? null
          : (selectedAnswerIndex ?? this.selectedAnswerIndex),
      showFeedback: showFeedback ?? this.showFeedback,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  @override
  List<Object?> get props => [questions, currentIndex, score, selectedAnswerIndex, showFeedback, isComplete];
}
