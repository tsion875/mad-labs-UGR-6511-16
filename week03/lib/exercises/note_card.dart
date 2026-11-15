
import 'package:flutter/material.dart';

void main() => runApp(const NoteCardPreview());

/// A preview card for one note: title, the start of the body, tags and the
/// date it was last edited.
class NoteCard extends StatelessWidget {
  const NoteCard({
    required this.title,
    required this.body,
    required this.edited,
    this.tags = const [],
    this.pinned = false,
    super.key,
  });

  final String title;
  final String body;
  final DateTime edited;
  final List<String> tags;
  final bool pinned;

  /// The widest the card may be, on any screen.
  static const maxCardWidth = 560.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: maxCardWidth,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and optional pin icon
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      if (pinned)
                        const Icon(Icons.push_pin),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Note body
                  Text(
                    body,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium,
                  ),

                  const SizedBox(height: 8),

                  // Tags and edited date
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: tags.map((tag) {
                            return Chip(
                              label: Text(tag),
                              labelStyle: theme.textTheme.labelSmall,
                              visualDensity: VisualDensity.compact,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Date stays on the right
                      Text(
                        editedLabel(edited),
                        style: theme.textTheme.labelSmall,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const _months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

/// The date line of the card: 'Edited 14 Oct' for 14 October.
String editedLabel(DateTime date) =>
    'Edited ${date.day} ${_months[date.month - 1]}';

/// A small app that shows two sample cards in a list.
class NoteCardPreview extends StatelessWidget {
  const NoteCardPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteCard preview',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF00695C),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('NoteCard preview')),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            NoteCard(
              title: 'Shopping list for the field trip to Debre Libanos',
              body:
                  'Bread, water, two notebooks, the printed map and a '
                  'torch. Ask Abebe whether the bus leaves at seven or at '
                  'half past seven, and whether we need to bring our '
                  'student cards.',
              edited: DateTime(2026, 10, 14),
              tags: const ['trip', 'shopping', 'week 3', 'remember'],
              pinned: true,
            ),
            NoteCard(
              title: 'Layout',
              body: 'Constraints go down, sizes go up.',
              edited: DateTime(2026, 10, 2),
            ),
          ],
        ),
      ),
    );
  }
}
