import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mini_games/app.dart';
import 'package:mini_games/features/profile/presentation/providers/progress_notifier.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('HomeScreen Widget Tests', () {
    testWidgets('displays app title', (tester) async {
      final prefs = await SharedPreferences.getInstance();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MiniGamesApp(),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Mini Games'), findsOneWidget);
    });

    testWidgets('displays XP bar with Level 1', (tester) async {
      final prefs = await SharedPreferences.getInstance();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MiniGamesApp(),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Level 1'), findsOneWidget);
    });

    testWidgets('displays Math game tile', (tester) async {
      final prefs = await SharedPreferences.getInstance();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MiniGamesApp(),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Math'), findsOneWidget);
    });

    testWidgets('displays Spelling game tile', (tester) async {
      final prefs = await SharedPreferences.getInstance();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MiniGamesApp(),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Spelling'), findsOneWidget);
    });

    testWidgets('displays XP progress text', (tester) async {
      final prefs = await SharedPreferences.getInstance();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MiniGamesApp(),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('0 / 100 XP'), findsOneWidget);
    });

    testWidgets('displays game tiles in grid', (tester) async {
      final prefs = await SharedPreferences.getInstance();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MiniGamesApp(),
        ),
      );
      await tester.pumpAndSettle();
      // Both game tiles should be visible
      expect(find.text('Math'), findsOneWidget);
      expect(find.text('Spelling'), findsOneWidget);
      // GameTile cards
      expect(find.byType(Card), findsWidgets);
    });
  });
}
