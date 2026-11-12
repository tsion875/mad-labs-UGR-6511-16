## Task 2 — Hello World and hot reload

Step| Prediction: what will you see?| What you saw |Same?
a. | The greeting will change|The greeting changed to my native language immediately after hot reload. The app did not restart.| yes
b. | it will still display amharic greeting |The app still displayed the Amharic greeting after hot reload.| yes
c. |The app will restart and display the Placeholder widget instead of the Amharic greeting|After hot restart, the app displayed the Placeholder widget (a large X) instead of the Amharic greeting.| yes
selfcheck: Hot reload changed the running app without restarting it. It preserves the app's current state and does not rerun main(). while hot restart restarts the app from the beginning, reruns main(), and resets the app's state.

task5:
for 'addis ababa' will become 'Addis Ababa'
for 'hello world' The function will show an error. The repeated spaces create an empty word, and the code tries to access its first character.
for '' The function throws an error because the input produces an empty word.
After running:Observations

1. For `'addis ababa'`, the function returned `Addis Ababa` as predicted.
2. For `'hello  world'`, the function threw a RangeError because it tried to access the first character of an empty string.
3. For `''`, the function also threw a RangeError because it tried to access the first character of an empty string.

## Mark (Incorrect Statements)

**1. Original statement:** "It ignores repeated spaces, so 'hello world' works correctly too."

- What I observed: The function threw a RangeError when I tested two spaces between words.
- Correction: `split(' ')` does not ignore repeated spaces. It creates an empty string between consecutive spaces.
- How I found out: Running the function.

**2. Original statement:** "This function handles all inputs safely."

- What I observed: The function threw a RangeError for an empty string.
- Correction: The function cannot safely handle empty words because it tries to access their first character.
- How I found out: Running the function.

**3. Original statement:** "'hello'.capitalize() which Dart provides on every String."

- What I observed: Dart's String documentation does not provide a built-in `capitalize()` method.
- Correction: Dart does not provide a built-in `capitalize()` method on every String.
- How I found out: Dart documentation.

I fixed the function by checking whether each word is empty before accessing its first character. If it is empty, the function returns it unchanged. This allows repeated spaces and empty input to work without throwing an error.

### Fix (Result)

I added an empty-word check before accessing the first character. The corrected function successfully handled all three inputs without throwing errors. It also preserved repeated spaces.
