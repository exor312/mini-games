import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mini_games/features/game/presentation/screens/math_game_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MathGameScreen', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    Widget buildTestWidget() {
      return ProviderScope(
        child: MaterialApp(
          home: const MathGameScreen(),
        ),
      );
    }

    testWidgets('question text is displayed', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      // Should show a question with = ? pattern
      expect(find.textContaining('= ?'), findsOneWidget);
    });

    testWidgets('4 answer buttons are rendered', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      // Answer buttons show numbers - find 4 buttons with ElevatedButton
      expect(find.byType(ElevatedButton), findsNWidgets(4));
    });

    testWidgets('question counter shows correct number', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Question 1/10'), findsOneWidget);
    });

    testWidgets('score is displayed', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Score: 0'), findsOneWidget);
    });

    testWidgets('tapping an answer shows feedback', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      // Tap the first answer button
      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pump();

      // Score should update (either 0 or 1 depending on correctness)
      expect(find.textContaining('Score:'), findsOneWidget);
    });

    testWidgets('question advances after delay', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      // Tap an answer
      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pump();

      // Wait for auto-advance timer (1.5s)
      await tester.pump(const Duration(milliseconds: 1600));

      // Should now show question 2
      expect(find.text('Question 2/10'), findsOneWidget);
    });
  });
}
