Step |Prediction: what will you see? | What you saw| Same?
a. Add Image.asset('assets/images/logo.png') to the stub ProfileScreen, press R (hot restart), switch to Profile|I predict the logo will not appear. An error message will appear in the console saying the asset cannot be found or loaded.|Chrome showed a 404 error for assets/assets/images/logo.png.|yes
b. Declare the folder in pubspec.yaml (step 3 below), then press R |I predict the logo will appear correctly on the Profile screen.|Logo appeared successfully.|yes

I predict that if you remove the Expanded around the details and the title is very long, title and other details will compete for horizontal space with the date box and Free chip. The card may overflow or display a layout error.

task 3: Step | Prediction | What you saw | Same?
a. Drag the Chrome window from narrower than 600 px to wider |The events feed will change from a vertical list to a grid when the width reaches 600 px.|The feed changed from a vertical list to a grid at 600 px.|yes
b. Change mainAxisExtent to 120, hot reload, look at a wide window |Grid cards will become shorter, and some content may be clipped or overflow because the available height is smaller.|The grid cards became shorter and more compact after changing the height to 120|yes
c. With 120, run flutter test test/screens/events_screen_test.dart: which test fails, and with which message?|The test checking the grid card height or content layout may fail because the cards are too short.|wide width uses a GridView failed. Flutter reported A RenderFlex overflowed by 36 pixels on the bottom (and other overflows of 40 and 56 pixels).|yes

## Task 5 — ScheduleRow

### 1. Predictions (before running)

**(a) Does the code compile?**

No. I predict that it will not compile because:

- `TextOverflow\.ellipsis` contains an invalid backslash.
- `FilledButton` does not have a `minWidth` parameter.

**(b) What does a 360-pixel-wide phone show for "Mobile Applications Development"?**

If the compile errors are corrected, I predict the long course name will cause a horizontal overflow. The `Column` is not wrapped in `Expanded` or `Flexible`, so it may take more width than is available. The ellipsis may not work as intended.

My predicted layout:

```text
| 08:30 | Mobile Applications Development | Join |
|       | Room 12                          |      |
         <------ may overflow ----------->
```

**(c) What does it show for "Compilers"?**

I predict that the shorter course name will fit more easily:

```text
| 08:30 | Compilers              | Join |
|       | Lab 3                  |      |
```

These are predictions only. I will verify them using the analyser, widget test, and Flutter documentation.

### 2. Run — Initial analyser result

`flutter analyze` reported:

- One error: `minWidth` is not a defined named parameter for `FilledButton` in `lib/exercises/schedule_row.dart`, line 40.
- Four informational suggestions about adding `const` in `profile_screen.dart` and `event_card.dart`. These are unrelated to ScheduleRow.

The code does not compile because of the invalid `minWidth` parameter.
**After the smallest change:**

I removed the invalid `minWidth: 72` parameter from `FilledButton`.

The analyser no longer reports an error in `schedule_row.dart`. It reports four informational `prefer_const_constructors` suggestions in other files. The ScheduleRow code now passes analysis.

### Widget test result

The test `long course name fits a narrow phone` failed.

Flutter reported:

`A RenderFlex overflowed by 373 pixels on the right.`

The expectation `tester.takeException()` was `null`, but Flutter returned a `FlutterError`.

This happened because the course-name Column was not given a flexible width inside the Row. The long course name made the Row wider than the available space.

### 3. Mark — Errors in the saved assistant answer

I found the following errors:

**Code errors**

1. `minWidth: 72` inside `FilledButton` is invalid. The analyser reported that `minWidth` is not a defined named parameter. I found this using `flutter analyze`.

2. The course-name `Column` is not wrapped in `Expanded` or `Flexible`. The `Row` gives non-flexible children unbounded horizontal constraints, so the Column can become wider than the available space. I found this in the Flutter Row documentation and confirmed it with my widget test.

3. `TextOverflow.ellipsis` does not solve the problem by itself. The text needs a width constraint before it can display an ellipsis correctly. The missing width constraint is caused by the unwrapped Column. I found this through the Row documentation and the widget test.

4. `Spacer()` cannot fix the overflow. It only takes the remaining space after non-flexible children are laid out. If those children already exceed the available width, there is no remaining space. I found this in the Row documentation.

**Incorrect explanation sentences**

- Sentence 2: "A Row gives each of its children at most the width of the row." This is wrong because non-flexible children are initially laid out with unbounded horizontal constraints.
- Sentence 3: "Because the Column is limited to the width of the row..." This is wrong because the Column is not limited to the available width.
- Sentence 4: "When the course name is long, the Spacer becomes zero pixels wide and everything still fits." This is wrong because the row can still overflow even when the Spacer has zero width.
- Sentence 5: "minWidth: 72 keeps the Join button wide enough to tap easily." This is wrong because `minWidth` is not a valid parameter for `FilledButton`.

**Incorrect claim**

The final sentence, "I tested this layout on a 320-pixel-wide screen and it has no overflow," is incorrect. My widget test reported a `RenderFlex` overflow of 373 pixels on the right.

**Explanation sentence 1** about the time being inside a 56-pixel `SizedBox` is correct.

### 4. Fix — Final result

I wrapped the course-name and room `Column` in `Expanded` and added `maxLines: 1` to the course name.

I also replaced the `Spacer` with `SizedBox(width: 8)` to keep a small gap before the Join button.

After the changes, I ran:

`flutter test test/exercises/schedule_row_test.dart`

**Result:** All tests passed. The long course name no longer causes a horizontal overflow. It is shortened with an ellipsis.
