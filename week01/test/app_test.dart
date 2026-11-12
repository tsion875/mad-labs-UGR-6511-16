// This test passes once you finish Task 3 of the lab.
// Run it with: flutter test test/app_test.dart
import 'package:flutter_test/flutter_test.dart';

import 'package:campus_companion/app.dart';

void main() {
  testWidgets('app displays the AboutScreen', (tester) async {
    await tester.pumpWidget(const CampusCompanionApp());

    expect(find.text('About Me'), findsOneWidget);
    expect(find.text('Tsion'), findsOneWidget);
    expect(find.text('Computer Science'), findsOneWidget);
  });
}

// TODO(lab): once you have created CampusCompanionApp in lib/app.dart,
// import it, pump it instead of MainApp, and expect the AppBar title
// 'Campus Companion' and the welcome text.
