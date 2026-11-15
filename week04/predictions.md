### Task 1 — Read and predict: named routes

| Step                                                                                       | Prediction                                                                                      | What you saw                                                                                                           | Same? |
| ------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- | ----- |
| a. Open the address `/#/events/42`. Which screen appears?                                  | The Event 42 screen appears, showing Career fair.                                               | The Event 42 screen appeared, showing Career fair.                                                                     | Yes   |
| b. Press the back arrow in the app bar. Which screen appears? Press it again.              | First, the Events list appears. Press back again and the Named routes demo home screen appears. | First, the Events list appeared. Pressing back again returned to the home screen.                                      | Yes   |
| c. Open the address `/#/events/abc`. Which screen appears, and what does the console show? | The Unknown route screen appears. No custom error should be printed in the console.             | The Unknown route screen appeared, displaying `No screen for /events/abc`. No custom error was printed in the console. | Yes   |

## 2. Explain

**1. Which line turns the text `42` into the number 42?**

```dart
final id = int.tryParse(segments[1]);
```

It converts the URL text into an integer. If the text is not a valid number, it returns `null`.

**2. What does `generateDemoRoute` return for `/events/5`, and which screen does the user then see?**

It returns `null` because event ID 5 does not exist in `demoEvents`. Flutter then uses `onUnknownRoute`, so the user sees the Unknown route screen.

**3. The app must also open `/events/42/photos/3`. Which lines would you have to add or change?**

We would need to update the route parsing condition to recognize four URL segments instead of two, extract the event ID and photo ID, and create a route that displays the requested photo. We would also need a screen to display the event photo.
Step Prediction What you saw Same?
a. Tap a card. Is the bottom navigation bar visible on the detail?|No. The bottom navigation bar will not be visible on the detail screen.
b. With the detail open, tap Profile, then Events. What do you see?|The Profile and Events tabs cannot be tapped while the detail screen is open because the bottom navigation bar is covered.
(a) Tap the third icon (Profile): The app may throw an exception because the bottom navigation has three destinations but the router has four branches.

(b) Enter #/profile: The Profile screen should still open because its route is registered in the router.

### Task 3 — Four-tab navigation

**Prediction:**

- (a) Removing Notes from the bottom bar while keeping four router branches causes a mismatch. Tapping the third icon may select the wrong branch or trigger an assertion.
- (b) Typing `#/profile` should still open the Profile screen because the route remains registered.

**What I observed:**

- (a) An exception occurred when the navigation destinations and router branches did not match.
- (b) Profile should remain accessible directly through its route.
  task 4: Address |Prediction| What you saw| Same?
  a. #/events/e3 | The Event Detail screen should open for event e3.|The event detail screen opened.|yes
  b. #/events/nope|The app should display Event not found because nope is not a valid event ID|The page displayed “Event not found”.|yes
  c. #/nothing|The app should display a Not found page with the message No route for /nothing.|The Not found page displayed “No route for /nothing”.|yes
  task 5:The About page will open. When I press Back, I predict the drawer will still be open because the line that closes it was removed.
  task 5:
  Step| Prediction| What you saw |Same?
  a. Remove the line that closes the drawer, open About, press Back |The drawer will remain open because we removed the line that closes it. |Pressing Back took me back to the navigation bar; the drawer was closed.| No
  task 6:
  Step| Prediction
  a. Edit the name to Hana Tadesse. What does the address end with on the edit page the next time you open it? |The address should contain ?name=Hana+Tadesse (or an equivalent URL-encoded version), preserving the space in the name.|After saving Hana Tadesse and reopening Edit Profile, the URL ended with ?name=Hana+Tadesse.
  b. Open the edit page and press Back. What does push return? | It should return null because I pressed Back without saving.|Pressing Back without saving returned null. The profile kept the previous saved name, Hana Tadesse.
  task7:
  Step |Prediction
  Self-check 3: Remove Expanded around TabBarView |The screen will likely show a layout error because TabBarView needs a bounded height inside the Column.|The app throws a layout error because TabBarView receives unbounded height. Adding Expanded fixes the problem by giving TabBarView the remaining available space
