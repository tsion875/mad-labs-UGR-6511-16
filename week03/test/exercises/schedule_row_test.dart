import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../lib/exercises/schedule_row.dart';

void main() {
  testWidgets('long course name fits a narrow phone',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 320,
            child: ScheduleRow(
              time: '08:30',
              course: 'Mobile Applications Development',
              room: 'Lab 3',
            ),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
  });
}