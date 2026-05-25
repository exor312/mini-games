import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/game_result.dart';

class GameResultModel {
  static const String _historyKey = 'game_history';

  Future<void> save(GameResult result) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await _getRawHistory();
    history.add(jsonEncode({
      'gameType': result.gameType.name,
      'score': result.score,
      'xpEarned': result.xpEarned,
      'playedAt': result.playedAt.toIso8601String(),
      'correctAnswers': result.correctAnswers,
      'totalQuestions': result.totalQuestions,
    }));
    await prefs.setStringList(_historyKey, history);
  }

  Future<List<GameResult>> loadHistory() async {
    final raw = await _getRawHistory();
    final results = <GameResult>[];
    for (final item in raw) {
      try {
        final map = jsonDecode(item) as Map<String, dynamic>;
        results.add(GameResult(
          gameType: GameType.values.byName(map['gameType'] as String),
          score: map['score'] as int,
          xpEarned: map['xpEarned'] as int,
          playedAt: DateTime.parse(map['playedAt'] as String),
          correctAnswers: map['correctAnswers'] as int,
          totalQuestions: map['totalQuestions'] as int,
        ));
      } catch (_) {
        // Skip corrupted entries
      }
    }
    results.sort((a, b) => b.playedAt.compareTo(a.playedAt));
    return results;
  }

  Future<int> getTotalGamesPlayed() async {
    final history = await _getRawHistory();
    return history.length;
  }

  Future<List<String>> _getRawHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_historyKey) ?? [];
  }
}
