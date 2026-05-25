import 'package:equatable/equatable.dart';

enum GameType {
  math,
  spelling;

  String get displayName {
    switch (this) {
      case GameType.math:
        return 'Math';
      case GameType.spelling:
        return 'Spelling';
    }
  }
}

class GameResult extends Equatable {
  const GameResult({
    required this.gameType,
    required this.score,
    required this.xpEarned,
    required this.playedAt,
    required this.correctAnswers,
    required this.totalQuestions,
  });

  final GameType gameType;
  final int score;
  final int xpEarned;
  final DateTime playedAt;
  final int correctAnswers;
  final int totalQuestions;

  GameResult copyWith({
    GameType? gameType,
    int? score,
    int? xpEarned,
    DateTime? playedAt,
    int? correctAnswers,
    int? totalQuestions,
  }) {
    return GameResult(
      gameType: gameType ?? this.gameType,
      score: score ?? this.score,
      xpEarned: xpEarned ?? this.xpEarned,
      playedAt: playedAt ?? this.playedAt,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      totalQuestions: totalQuestions ?? this.totalQuestions,
    );
  }

  @override
  List<Object?> get props => [gameType, score, xpEarned, playedAt, correctAnswers, totalQuestions];
}
