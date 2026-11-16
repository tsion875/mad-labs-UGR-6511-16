
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/note.dart';

part 'notes_notifier.g.dart';

/// The list of notes and the operations on it.
///
/// A Notifier owns mutable state and exposes methods that replace it. The
/// state is an *unmodifiable* list: every change builds a new list and
/// assigns it to `state`, which is how Riverpod knows to notify listeners.
/// Mutating the list in place (`state.add(...)`) would change nothing on
/// screen — and here it throws, so the mistake is caught immediately.
@riverpod
class Notes extends _$Notes {
  int _nextId = 1;

  @override
  List<Note> build() => const [];

  /// Adds a note with id `'n$_nextId'` (then increments) and returns it.
  Note add({required String title, required String body, DateTime? now}) {
    final note = Note(
      id: 'n${_nextId++}',
      title: title,
      body: body,
      updatedAt: now ?? DateTime.now(),
    );

    state = List.unmodifiable([...state, note]);

    return note;
  }

  /// Replaces the note with the same id, setting updatedAt to [now].
  void update(Note updated, {DateTime? now}) {
    final updatedNote = updated.copyWith(
      updatedAt: now ?? DateTime.now(),
    );

    state = List.unmodifiable([
      for (final note in state)
        if (note.id == updated.id) updatedNote else note,
    ]);
  }

  /// Removes the note with this id. Other notes stay.
  void remove(String id) {
    state = List.unmodifiable([
      for (final note in state)
        if (note.id != id) note,
    ]);
  }

  /// Flips `isPinned` of the note with this id.
  void togglePinned(String id) {
    state = List.unmodifiable([
      for (final note in state)
        if (note.id == id)
          note.copyWith(isPinned: !note.isPinned)
        else
          note,
    ]);
  }
}

/// Derived state: pinned first, then most recently updated. Recomputed
/// only when [notesProvider] changes.
@riverpod
List<Note> sortedNotes(Ref ref) {
  final notes = [...ref.watch(notesProvider)];

  notes.sort((a, b) {
    if (a.isPinned != b.isPinned) {
      return a.isPinned ? -1 : 1;
    }

    return b.updatedAt.compareTo(a.updatedAt);
  });

  return List.unmodifiable(notes);
}

/// One note by id, or null. A family provider.
@riverpod
Note? noteById(Ref ref, String id) {
  return ref.watch(notesProvider).where((n) => n.id == id).firstOrNull;
}
