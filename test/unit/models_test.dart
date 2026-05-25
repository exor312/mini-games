import 'package:flutter_test/flutter_test.dart';
import 'package:mini_games/core/config/app_constants.dart';
import 'package:mini_games/core/errors/failures.dart';
import 'package:mini_games/features/game/domain/entities/game_result.dart';

void main() {
  group('AppConstants', () {
    test('xpThresholdsForLevel returns correct values', () {
      expect(AppConstants.xpThresholdsForLevel(1), 0);
      expect(AppConstants.xpThresholdsForLevel(2), 100);
      expect(AppConstants.xpThresholdsForLevel(3), 250);
      expect(AppConstants.xpThresholdsForLevel(4), 500);
      expect(AppConstants.xpThresholdsForLevel(5), 1000);
      expect(AppConstants.xpThresholdsForLevel(6), 1500);
      expect(AppConstants.xpThresholdsForLevel(7), 2000);
    });

    test('maxLevel is 50', () {
      expect(AppConstants.maxLevel, 50);
    });

    test('streakMilestones contains expected values', () {
      expect(AppConstants.streakMilestones, [3, 7, 14, 30]);
    });

    test('GameType displayName', () {
      expect(GameType.math.displayName, 'Math');
      expect(GameType.spelling.displayName, 'Spelling');
    });
  });

  group('Failures', () {
    test('CacheFailure has default message', () {
      const f = CacheFailure();
      expect(f.message, 'A cache error occurred.');
    });

    test('DatabaseFailure has default message', () {
      const f = DatabaseFailure();
      expect(f.message, 'A database error occurred.');
    });

    test('UnexpectedFailure has custom message', () {
      const f = UnexpectedFailure(message: 'Oops');
      expect(f.message, 'Oops');
    });

    test('Failures are equatable', () {
      const f1 = CacheFailure();
      const f2 = CacheFailure();
      expect(f1, f2);
    });
  });

  group('GameResult', () {
    test('creates GameResult with all fields', () {
      final now = DateTime.now();
      final result = GameResult(
        gameType: GameType.math,
        score: 100,
        xpEarned: 10,
        playedAt: now,
        correctAnswers: 8,
        totalQuestions: 10,
      );
      expect(result.gameType, GameType.math);
      expect(result.score, 100);
      expect(result.xpEarned, 10);
      expect(result.correctAnswers, 8);
      expect(result.totalQuestions, 10);
    });

    test('copyWith updates fields', () {
      final now = DateTime.now();
      final result = GameResult(
        gameType: GameType.math,
        score: 100,
        xpEarned: 10,
        playedAt: now,
        correctAnswers: 8,
        totalQuestions: 10,
      );
      final updated = result.copyWith(score: 200);
      expect(updated.score, 200);
      expect(updated.gameType, GameType.math);
    });

    test('Equatable works correctly for same values', () {
      final now = DateTime.now();
      final r1 = GameResult(
        gameType: GameType.math,
        score: 100,
        xpEarned: 10,
        playedAt: now,
        correctAnswers: 8,
        totalQuestions: 10,
      );
      final r2 = GameResult(
        gameType: GameType.math,
        score: 100,
        xpEarned: 10,
        playedAt: now,
        correctAnswers: 8,
        totalQuestions: 10,
      );
      expect(r1, r2);
    });

    test('props contains all fields', () {
      final now = DateTime.now();
      final result = GameResult(
        gameType: GameType.spelling,
        score: 50,
        xpEarned: 5,
        playedAt: now,
        correctAnswers: 5,
        totalQuestions: 5,
      );
      expect(result.props, [GameType.spelling, 50, 5, now, 5, 5]);
    });
  });
}
