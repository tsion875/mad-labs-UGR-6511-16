
import 'package:flutter/material.dart';

import '../models/event.dart';

/// One event in the feed.
// TODO(lab): Task 2 — replace the ListTile with the card pictured in
// lab/README.md, Task 2. test/widgets/event_card_test.dart is the
// contract; the widget list is in the task's "Step-by-step help".
class EventCard extends StatelessWidget {
  const EventCard({required this.event, super.key});

  final Event event;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;

    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Date box
                Container(
                  width: 56,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: colors.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        event.start.day.toString(),
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.onPrimaryContainer,
                        ),
                      ),
                      Text(
                        months[event.start.month - 1],
                        style: textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // Event details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleMedium,
                      ),
                      Text.rich(
                        TextSpan(
                          style: textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: event.venue.label,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: ' · ${event.venue.location}',
                            ),
                          ],
                        ),
                      ),
                      if (event.description.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            event.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodySmall,
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Show Free chip only for free events
                if (event.isFree)
                  Chip(
                    label: const Text('Free'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


