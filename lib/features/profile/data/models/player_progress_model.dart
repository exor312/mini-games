import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/config/app_constants.dart';
import '../../domain/entities/player_progress.dart';

class PlayerProgressModel {
  static const String _xpKey = 'total_xp';
  static const String _levelKey = 'player_level';
  static const String _streakKey = 'streak_days';
  static const String _lastPlayedKey = 'last_played_date';

  Future<void> save(PlayerProgress progress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_xpKey, progress.totalXP);
    await prefs.setInt(_levelKey, progress.level);
    await prefs.setInt(_streakKey, progress.streakDays);
    if (progress.lastPlayedDate != null) {
      await prefs.setString(_lastPlayedKey, progress.lastPlayedDate!.toIso8601String());
    }
  }

  Future<PlayerProgress> load() async {
    final prefs = await SharedPreferences.getInstance();
    final totalXP = prefs.getInt(_xpKey) ?? 0;
    return PlayerProgress(
      totalXP: totalXP,
      level: prefs.getInt(_levelKey) ?? 1,
      streakDays: prefs.getInt(_streakKey) ?? 0,
      lastPlayedDate: prefs.getString(_lastPlayedKey) != null
          ? DateTime.parse(prefs.getString(_lastPlayedKey)!)
          : null,
    );
  }

  int calculateLevel(int totalXP) {
    for (int lvl = 1; lvl <= AppConstants.maxLevel; lvl++) {
      if (totalXP < AppConstants.xpThresholdsForLevel(lvl + 1)) {
        return lvl;
      }
    }
    return AppConstants.maxLevel;
  }
}
