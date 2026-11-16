# Task 4 — Bookmark Design Decisions

1. **Shared state:** Use a `Set<String>` containing the IDs of bookmarked talks. A set prevents duplicate bookmarks and makes adding, removing, and checking a bookmark straightforward.

2. **Widget responsibilities:** The app-bar count, talk list, and Saved page watch the shared provider so they stay synchronized. The bookmark button changes the state by calling a notifier method through `ref.read`.

3. **Feature structure:** If bookmarks were part of Campus Companion:
   - `Talk` would go in `features/bookmarks/domain/` because it represents the feature's domain model.
   - The bookmark provider/notifier would go in `features/bookmarks/data/` because it manages the feature's shared state.
   - The app bar, talk list, and Saved page widgets would go in `features/bookmarks/presentation/` because they display and interact with the feature.

TA Checkpoint

**Prediction:** If I change `ref.watch(bookmarkedTalkIdsProvider)` to `ref.read(bookmarkedTalkIdsProvider)` inside `BookmarkButton`, the button will no longer listen for changes to the provider. Its icon may not update automatically when the bookmark state changes.

**What I observed:** `ref.watch` listens for provider changes and rebuilds the widget. `ref.read` only gets the current value without listening.
