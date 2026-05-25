import 'dart:math';

import '../entities/math_question.dart';

final _random = Random();

MathQuestion generateQuestion() {
  final bool isAddition = _random.nextBool();
  int operand1;
  int operand2;
  int correctAnswer;
  String operator;

  if (isAddition) {
    operand1 = _random.nextInt(20) + 1;
    operand2 = _random.nextInt(20) + 1;
    correctAnswer = operand1 + operand2;
    operator = '+';
  } else {
    // Subtraction: ensure non-negative result
    operand1 = _random.nextInt(20) + 1;
    operand2 = _random.nextInt(operand1) + 1;
    correctAnswer = operand1 - operand2;
    operator = '-';
  }

  // Generate 3 wrong answers that are different from the correct answer
  final wrongAnswers = <int>{};
  while (wrongAnswers.length < 3) {
    // Generate wrong answers within a reasonable range of the correct answer
    int wrong = correctAnswer + _random.nextInt(11) - 5;
    if (wrong != correctAnswer && wrong >= 0) {
      wrongAnswers.add(wrong);
    }
  }

  // Combine and shuffle
  final allOptions = [correctAnswer, ...wrongAnswers];
  allOptions.shuffle(_random);

  return MathQuestion(
    operand1: operand1,
    operand2: operand2,
    operator: operator,
    correctAnswer: correctAnswer,
    options: allOptions,
  );
}
