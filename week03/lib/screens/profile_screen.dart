
import 'package:flutter/material.dart';

/// Static profile screen.
// TODO(lab): Task 4 — write the 320 px test in
// test/screens/profile_screen_test.dart first, then build the screen
// described in lab/README.md, Task 4 (portrait and landscape).
// test/screens/profile_screen_test.dart is the contract.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.orientationOf(context) == Orientation.landscape;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: isLandscape
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(child: _ProfileHeader()),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        _StatsRow(),
                        _ProfileActions(),
                        _OrientationBanner(),
                      ],
                    ),
                  ),
                ],
              )
            : const Column(
                children: [
                  _ProfileHeader(),
                  _StatsRow(),
                  _ProfileActions(),
                  _OrientationBanner(),
                ],
              ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        const CircleAvatar(
          radius: 48,
          backgroundImage: AssetImage('assets/images/logo.png'),
        ),
        const SizedBox(height: 12),
        Text(
          'Sara Bekele',
          style: textTheme.headlineSmall,
        ),
        const SizedBox(height: 4),
        RichText(
          text: TextSpan(
            style: textTheme.bodyMedium,
            children: const [
              TextSpan(text: 'B.Sc. '),
              TextSpan(
                text: 'Computer Science',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' · 3rd year'),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Row(
        children: [
          Expanded(child: _StatTile(value: '12', label: 'Events')),
          Expanded(child: _StatTile(value: '34', label: 'Notes')),
          Expanded(child: _StatTile(value: '3', label: 'Posts')),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.value,
    required this.label,
  });

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(value, style: textTheme.titleLarge),
        Text(label, style: textTheme.bodyMedium),
      ],
    );
  }
}

class _ProfileActions extends StatelessWidget {
  const _ProfileActions();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.edit),
          label: const Text('Edit profile'),
        ),
        OutlinedButton(
          onPressed: () {},
          child: const Text('Share'),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Sign out'),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings),
          tooltip: 'Settings',
        ),
      ],
    );
  }
}

class _OrientationBanner extends StatelessWidget {
  const _OrientationBanner();

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.orientationOf(context).name;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text('Orientation: $orientation'),
    );
  }
}
