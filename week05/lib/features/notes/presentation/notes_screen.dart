
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/router.dart';
import '../data/notes_notifier.dart';

class NotesScreen extends ConsumerWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final notes = ref.watch(sortedNotesProvider);

    return Scaffold(
      body: notes.isEmpty
          ? const Center(
              child: Text('No notes yet. Tap + to add one.'),
            )
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];

                return ListTile(
                  leading: Icon(
                    note.isPinned ? Icons.push_pin : Icons.notes,
                    color: note.isPinned
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                  title: Text(
                    note.title.trim().isEmpty
                        ? '(untitled)'
                        : note.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    note.body,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    tooltip: note.isPinned ? 'Unpin' : 'Pin',
                    icon: Icon(
                      note.isPinned
                          ? Icons.push_pin
                          : Icons.push_pin_outlined,
                    ),
                    onPressed: () {
                      ref
                          .read(notesProvider.notifier)
                          .togglePinned(note.id);
                    },
                  ),
                  onTap: () {
                    context.push(Routes.noteFor(note.id));
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(Routes.newNote),
        tooltip: 'New note',
        child: const Icon(Icons.add),
      ),
    );
  }
}
