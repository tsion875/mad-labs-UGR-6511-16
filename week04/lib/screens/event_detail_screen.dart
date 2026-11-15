import 'package:flutter/material.dart';

import '../models/event.dart';

/// Full-screen detail for one event. Pushed on the root navigator, so it
/// covers the bottom navigation bar and gets an automatic back button.
class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({required this.event, super.key});

  /// Null when the id in the URL does not match any event (deep link to a
  /// deleted event, typo in the address bar).
  final Event? event;

  @override
  Widget build(BuildContext context) {
    final event = this.event;
    if (event == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Event not found')),
      );
    }

    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(event.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(event.title, style: theme.textTheme.headlineSmall),
          const SizedBox(height: 8),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.schedule),
            title: Text('${event.start}'),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.place),
            title: Text(event.venue.label),
            subtitle: Text(event.venue.location),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.confirmation_number),
            title: Text(event.isFree ? 'Free' : 'Paid'),
          ),
          if (event.description.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(event.description, style: theme.textTheme.bodyLarge),
          ],
        ],
      ),
      // TODO(lab): Task 2 — add a BottomAppBar (CircularNotchedRectangle)
      // with Share, Add to calendar and Bookmark IconButtons, and a docked
      // FloatingActionButton.extended 'Register' (endDocked) that shows a
      // SnackBar 'Registered for <title>'.
            bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              tooltip: 'Share',
              onPressed: () {},
              icon: const Icon(Icons.share),
            ),
            IconButton(
              tooltip: 'Add to calendar',
              onPressed: () {},
              icon: const Icon(Icons.calendar_today),
            ),
            IconButton(
              tooltip: 'Bookmark',
              onPressed: () {},
              icon: const Icon(Icons.bookmark),
            ),
            const SizedBox(width: 48),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registered for ${event.title}')),
          );
        },
        icon: const Icon(Icons.how_to_reg),
        label: const Text('Register'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
