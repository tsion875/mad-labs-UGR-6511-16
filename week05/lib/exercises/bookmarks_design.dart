
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(const ProviderScope(child: BookmarksApp()));

class Talk {
  const Talk({required this.id, required this.title});

  final String id;
  final String title;
}

// Shared app state: a set of bookmarked talk IDs.
final bookmarkedTalkIdsProvider =
    NotifierProvider<BookmarkedTalkIdsNotifier, Set<String>>(
  BookmarkedTalkIdsNotifier.new,
);

class BookmarkedTalkIdsNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => <String>{};

  void toggle(String talkId) {
    if (state.contains(talkId)) {
      state = {...state}..remove(talkId);
    } else {
      state = {...state, talkId};
    }
  }
}

const talks = [
  Talk(id: 't1', title: 'Flutter on low-cost phones'),
  Talk(id: 't2', title: 'Amharic text input'),
  Talk(id: 't3', title: 'Testing with fakes'),
  Talk(id: 't4', title: 'Offline-first apps'),
];

class BookmarksApp extends StatelessWidget {
  const BookmarksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Talks', home: TalksPage());
  }
}

class TalksPage extends StatelessWidget {
  const TalksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Talks'),
        actions: [
          const BookmarkCount(),
          IconButton(
            tooltip: 'Saved',
            icon: const Icon(Icons.bookmarks_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (_) => const SavedPage()),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          for (final talk in talks)
            ListTile(
              title: Text(talk.title),
              trailing: BookmarkButton(talk: talk),
            ),
        ],
      ),
    );
  }
}

// Watches the shared state and changes it when pressed.
class BookmarkButton extends ConsumerWidget {
  const BookmarkButton({required this.talk, super.key});

  final Talk talk;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saved = ref.watch(bookmarkedTalkIdsProvider);
    final isSaved = saved.contains(talk.id);

    return IconButton(
      tooltip: isSaved ? 'Remove bookmark' : 'Bookmark',
      icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
      onPressed: () {
        ref.read(bookmarkedTalkIdsProvider.notifier).toggle(talk.id);
      },
    );
  }
}

// Watches the shared state and displays its size.
class BookmarkCount extends ConsumerWidget {
  const BookmarkCount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saved = ref.watch(bookmarkedTalkIdsProvider);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text('Bookmarks: ${saved.length}'),
      ),
    );
  }
}

// Watches the shared state and displays only bookmarked talks.
class SavedPage extends ConsumerWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saved = ref.watch(bookmarkedTalkIdsProvider);
    final savedTalks = talks
        .where((talk) => saved.contains(talk.id))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Saved')),
      body: savedTalks.isEmpty
          ? const Center(child: Text('No bookmarks yet.'))
          : ListView(
              children: [
                for (final talk in savedTalks)
                  ListTile(
                    title: Text(talk.title),
                    trailing: BookmarkButton(talk: talk),
                  ),
              ],
            ),
    );
  }
}
