/// App-wide constants for the Mini Games application.
abstract final class AppConstants {
  AppConstants._();

  static const int maxLevel = 50;

  static const List<int> streakMilestones = [3, 7, 14, 30];

  static int xpThresholdsForLevel(int level) {
    if (level <= 1) return 0;
    if (level == 2) return 100;
    if (level == 3) return 250;
    if (level == 4) return 500;
    if (level == 5) return 1000;
    return 1000 + (level - 5) * 500;
  }
}
