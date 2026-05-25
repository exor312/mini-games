import 'package:go_router/go_router.dart';
import '../../features/game/domain/entities/game_result.dart';
import '../../features/game/presentation/screens/game_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/results/presentation/screens/results_screen.dart';
import '../../features/streak/presentation/screens/streak_calendar_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: HomeScreen.routePath,
  routes: [
    GoRoute(
      path: HomeScreen.routePath,
      name: HomeScreen.routeName,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: GameScreen.routePath,
      name: GameScreen.routeName,
      builder: (context, state) {
        final typeStr = state.pathParameters['type'] ?? 'math';
        final gameType = typeStr == 'spelling'
            ? GameType.spelling
            : GameType.math;
        return GameScreen(gameType: gameType);
      },
    ),
    GoRoute(
      path: ResultsScreen.routePath,
      name: ResultsScreen.routeName,
      builder: (context, state) {
        final extra = state.extra as Map<String, int>?;
        return ResultsScreen(
          score: extra?['score'] ?? 0,
          xpEarned: extra?['xpEarned'] ?? 0,
        );
      },
    ),
    GoRoute(
      path: ProfileScreen.routePath,
      name: ProfileScreen.routeName,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: StreakCalendarScreen.routePath,
      name: StreakCalendarScreen.routeName,
      builder: (context, state) => const StreakCalendarScreen(),
    ),
  ],
);
