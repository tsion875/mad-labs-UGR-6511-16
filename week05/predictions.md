| Step                                                                                                        | Prediction                                                                                                                    | What you saw                                     | Same? |
| ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------ | ----- |
| a. Add a note, switch to Profile, switch back to Notes. Is the note there?                                  | Yes. The note should still be there because Riverpod stores the notes state outside the NotesScreen widget.                   | The note was still there after switching tabs.   | yes   |
| b. Change ref.watch(sortedNotesProvider) to ref.read(...), hot reload, add a note. What does the list show? | The list will not automatically update when a new note is added because ref.read does not listen for changes in the provider. | The Second Test note did not appear in the list. | Yes   |

Why do notes stay when switching tabs, when the Week 4 profile name lived in one widget?

The notes stay because they are stored in a Riverpod provider outside the NotesScreen widget. When I switch tabs, the NotesScreen can be rebuilt, but the provider keeps the notes state.

In Week 4, the profile name was stored in the widget's local state. When the widget was removed, its local state was lost.

Therefore, Riverpod keeps state independently of the screen, while local widget state belongs to a particular widget.
