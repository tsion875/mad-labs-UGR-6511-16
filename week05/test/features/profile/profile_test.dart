
import 'package:campus_companion/core/router/router.dart';
import 'package:campus_companion/features/profile/data/profile_notifier.dart';
import 'package:campus_companion/features/profile/domain/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers.dart';

void main() {
  test('setName trims and ignores empty input', () {
    final container = ProviderContainer.test();
    final notifier = container.read(profileProvider.notifier);

    notifier.setName('  Hana  ');
    expect(container.read(profileProvider).name, 'Hana');

    notifier.setName('   ');
    expect(container.read(profileProvider).name, 'Hana');
  });

  testWidgets('editing the name updates the provider and the screen',
      (tester) async {
    await pumpApp(tester, initialLocation: Routes.profile);
    expect(find.text('Sara Bekele'), findsOneWidget);

    await tester.tap(find.text('Edit profile'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Hana Tadesse');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Hana Tadesse'), findsOneWidget);
  });

  testWidgets('profile screen displays values from profileProvider override',
      (tester) async {
    await pumpApp(
      tester,
      initialLocation: Routes.profile,
      overrides: [
        profileProvider.overrideWith(() => _TestProfileNotifier()),
      ],
    );

    expect(find.text('Hana Tadesse'), findsOneWidget);

    expect(
      find.text(
        'B.Sc. Software Engineering · year 4',
        findRichText: true,
      ),
      findsOneWidget,
    );
  });
}

class _TestProfileNotifier extends ProfileNotifier {
  @override
  Profile build() => const Profile(
        name: 'Hana Tadesse',
        programme: 'Software Engineering',
        year: 4,
      );
}
