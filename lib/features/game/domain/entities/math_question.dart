import 'package:equatable/equatable.dart';

class MathQuestion extends Equatable {
  const MathQuestion({
    required this.operand1,
    required this.operand2,
    required this.operator,
    required this.correctAnswer,
    required this.options,
  });

  final int operand1;
  final int operand2;
  final String operator;
  final int correctAnswer;
  final List<int> options;

  MathQuestion copyWith({
    int? operand1,
    int? operand2,
    String? operator,
    int? correctAnswer,
    List<int>? options,
  }) {
    return MathQuestion(
      operand1: operand1 ?? this.operand1,
      operand2: operand2 ?? this.operand2,
      operator: operator ?? this.operator,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      options: options ?? this.options,
    );
  }

  String get questionText => '$operand1 $operator $operand2 = ?';

  @override
  List<Object?> get props => [operand1, operand2, operator, correctAnswer, options];
}
