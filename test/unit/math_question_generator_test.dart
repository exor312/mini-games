import 'package:flutter_test/flutter_test.dart';
import 'package:mini_games/features/game/domain/utils/math_question_generator.dart';

void main() {
  group('generateQuestion', () {
    test('returns a MathQuestion', () {
      final question = generateQuestion();
      expect(question, isNotNull);
    });

    test('options has exactly 4 items', () {
      final question = generateQuestion();
      expect(question.options.length, 4);
    });

    test('correct answer is in options list', () {
      for (int i = 0; i < 20; i++) {
        final question = generateQuestion();
        expect(question.options.contains(question.correctAnswer), isTrue,
            reason: 'Run $i: options=${question.options}, correct=${question.correctAnswer}');
      }
    });

    test('addition operands are 1-20', () {
      for (int i = 0; i < 50; i++) {
        final question = generateQuestion();
        expect(question.operand1, greaterThanOrEqualTo(1));
        expect(question.operand1, lessThanOrEqualTo(20));
        expect(question.operand2, greaterThanOrEqualTo(1));
        expect(question.operand2, lessThanOrEqualTo(20));
      }
    });

    test('subtraction result is non-negative', () {
      // Run many times to hit subtraction cases
      for (int i = 0; i < 50; i++) {
        final question = generateQuestion();
        if (question.operator == '-') {
          expect(question.correctAnswer, greaterThanOrEqualTo(0),
              reason: '${question.operand1} - ${question.operand2} = ${question.correctAnswer}');
        }
      }
    });

    test('wrong answers differ from correct answer', () {
      for (int i = 0; i < 20; i++) {
        final question = generateQuestion();
        final wrongAnswers = question.options.where((o) => o != question.correctAnswer).toList();
        expect(wrongAnswers.length, 3);
        expect(wrongAnswers.toSet().length, 3,
            reason: 'Wrong answers should be unique');
      }
    });

    test('addition: answer equals operand1 + operand2', () {
      // Run until we get an addition question
      bool foundAddition = false;
      for (int i = 0; i < 100; i++) {
        final question = generateQuestion();
        if (question.operator == '+') {
          expect(question.correctAnswer, question.operand1 + question.operand2);
          foundAddition = true;
          break;
        }
      }
      expect(foundAddition, isTrue, reason: 'Should have generated at least one addition question');
    });

    test('subtraction: answer equals operand1 - operand2', () {
      bool foundSubtraction = false;
      for (int i = 0; i < 100; i++) {
        final question = generateQuestion();
        if (question.operator == '-') {
          expect(question.correctAnswer, question.operand1 - question.operand2);
          foundSubtraction = true;
          break;
        }
      }
      expect(foundSubtraction, isTrue, reason: 'Should have generated at least one subtraction question');
    });
  });
}
