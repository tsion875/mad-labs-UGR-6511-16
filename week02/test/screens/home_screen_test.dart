import 'package:campus_companion/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows loading indicator then check-in counter', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Initially, the loading indicator should appear.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Check-ins today: 0'), findsNothing);

    // Advance the test clock by two seconds.
    await tester.pump(const Duration(seconds: 2));

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Check-ins today: 0'), findsOneWidget);
  });

  testWidgets('tapping the FAB increments the check-in counter', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('Check-ins today: 0'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    expect(find.text('Check-ins today: 1'), findsOneWidget);
  });

  // TODO(lab): Task 2 — write this test first, before the FAB works, and
  // run it to see it fail. Pump HomeScreen, tap the FloatingActionButton
  // three times, and expect the text 'Check-ins today: 3'.
  testWidgets('FAB increments check-ins to 3', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    await tester.pump(const Duration(seconds: 2));

    final fab = find.byType(FloatingActionButton);

    await tester.tap(fab);
    await tester.tap(fab);
    await tester.tap(fab);

    await tester.pump();

    expect(find.text('Check-ins today: 3'), findsOneWidget);
  });

  testWidgets('the lifecycle logger is mounted only while the switch is on', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    await tester.pump(const Duration(seconds: 2));

    expect(find.byType(Card), findsNothing);

    await tester.tap(find.byType(Switch));
    await tester.pump();
    expect(find.byType(Card), findsOneWidget);

    await tester.tap(find.byType(Switch));
    await tester.pump();
    expect(find.byType(Card), findsNothing);
  });
}
