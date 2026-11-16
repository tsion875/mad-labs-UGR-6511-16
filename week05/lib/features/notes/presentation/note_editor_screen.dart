
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/notes_notifier.dart';

/// Creates a note (no [noteId]) or edits an existing one.
class NoteEditorScreen extends ConsumerStatefulWidget {
  const NoteEditorScreen({this.noteId, super.key});

  final String? noteId;

  bool get isNew => noteId == null;

  @override
  ConsumerState<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends ConsumerState<NoteEditorScreen> {
  late final TextEditingController _title;
  late final TextEditingController _body;

  @override
  void initState() {
    super.initState();

    String initialTitle = '';
    String initialBody = '';

    if (!widget.isNew) {
      final note = ref.read(noteByIdProvider(widget.noteId!));

      if (note != null) {
        initialTitle = note.title;
        initialBody = note.body;
      }
    }

    _title = TextEditingController(text: initialTitle);
    _body = TextEditingController(text: initialBody);
  }

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  void _save() {
    final notifier = ref.read(notesProvider.notifier);

    final title = _title.text.trim();
    final body = _body.text.trim();

    if (widget.isNew) {
      notifier.add(title: title, body: body);
    } else {
      final existing = ref.read(noteByIdProvider(widget.noteId!));

      if (existing != null) {
        notifier.update(
          existing.copyWith(
            title: title,
            body: body,
          ),
        );
      }
    }

    context.pop();
  }

  void _delete() {
    if (!widget.isNew) {
      ref.read(notesProvider.notifier).remove(widget.noteId!);
    }

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isNew ? 'New note' : 'Edit note'),
        actions: [
          if (!widget.isNew)
            IconButton(
              tooltip: 'Delete',
              icon: const Icon(Icons.delete_outline),
              onPressed: _delete,
            ),
          IconButton(
            tooltip: 'Save',
            icon: const Icon(Icons.check),
            onPressed: _save,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _title,
              autofocus: widget.isNew,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TextField(
                controller: _body,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Note',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
