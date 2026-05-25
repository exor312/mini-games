import 'package:flutter_test/flutter_test.dart';
import 'package:mini_games/features/game/presentation/providers/math_game_notifier.dart';

void main() {
  group('MathGameNotifier', () {
    late MathGameNotifier notifier;

    setUp(() {
      notifier = MathGameNotifier();
    });

    test('starts with score 0', () {
      expect(notifier.state.score, 0);
    });

    test('starts at question index 0', () {
      expect(notifier.state.currentIndex, 0);
    });

    test('starts with 10 questions', () {
      expect(notifier.state.questions.length, 10);
    });

    test('starts with isComplete false', () {
      expect(notifier.state.isComplete, false);
    });

    test('correct answer increments score by 1', () {
      final question = notifier.state.currentQuestion;
      final correctIndex = question.options.indexOf(question.correctAnswer);

      notifier.selectAnswer(correctIndex);

      expect(notifier.state.score, 1);
      expect(notifier.state.showFeedback, isTrue);
      expect(notifier.state.selectedAnswerIndex, correctIndex);
    });

    test('wrong answer does not increment score', () {
      final question = notifier.state.currentQuestion;
      // Find a wrong answer index
      int wrongIndex = -1;
      for (int i = 0; i < question.options.length; i++) {
        if (question.options[i] != question.correctAnswer) {
          wrongIndex = i;
          break;
        }
      }
      expect(wrongIndex, greaterThan(-1), reason: 'Should find a wrong answer');

      notifier.selectAnswer(wrongIndex);

      expect(notifier.state.score, 0);
      expect(notifier.state.showFeedback, isTrue);
    });

    test('advance moves to next question', () {
      final question = notifier.state.currentQuestion;
      final correctIndex = question.options.indexOf(question.correctAnswer);
      notifier.selectAnswer(correctIndex);
      notifier.advance();

      expect(notifier.state.currentIndex, 1);
      expect(notifier.state.showFeedback, isFalse);
      expect(notifier.state.selectedAnswerIndex, isNull);
    });

    test('advance resets selectedAnswerIndex and showFeedback', () {
      final question = notifier.state.currentQuestion;
      final correctIndex = question.options.indexOf(question.correctAnswer);
      notifier.selectAnswer(correctIndex);

      expect(notifier.state.showFeedback, isTrue);
      expect(notifier.state.selectedAnswerIndex, isNotNull);

      notifier.advance();

      expect(notifier.state.showFeedback, isFalse);
      expect(notifier.state.selectedAnswerIndex, isNull);
    });

    test('game completes after 10 questions', () {
      for (int i = 0; i < 10; i++) {
        final question = notifier.state.currentQuestion;
        final correctIndex = question.options.indexOf(question.correctAnswer);
        notifier.selectAnswer(correctIndex);
        notifier.advance();
      }

      // After 10 questions and 10 advances, game should be complete
      expect(notifier.state.isComplete, isTrue);
    });

    test('selectAnswer does nothing if showFeedback is already true', () {
      final question = notifier.state.currentQuestion;
      final correctIndex = question.options.indexOf(question.correctAnswer);
      notifier.selectAnswer(correctIndex);

      final scoreAfterFirst = notifier.state.score;

      // Try selecting again
      notifier.selectAnswer(correctIndex);

      expect(notifier.state.score, scoreAfterFirst);
    });

    test('reset restarts the game', () {
      // Play a few questions
      final question = notifier.state.currentQuestion;
      final correctIndex = question.options.indexOf(question.correctAnswer);
      notifier.selectAnswer(correctIndex);
      notifier.advance();

      expect(notifier.state.currentIndex, 1);

      notifier.reset();

      expect(notifier.state.currentIndex, 0);
      expect(notifier.state.score, 0);
      expect(notifier.state.isComplete, isFalse);
      expect(notifier.state.showFeedback, isFalse);
    });
  });
}
