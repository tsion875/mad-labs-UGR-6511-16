Step| Prediction| What you saw| Same?
a. Open the address …/#/events/42. Which screen appears? | The Event 42 screen appears, showing Career fair.
b. Then press the back arrow in the app bar. Which screen appears? Press it again.|First, the Events list appears. Press back again and the Named routes demo home screen appears.
c. Open the address …/#/events/abc. Which screen appears, and what does the console show? |The app displays the Named routes demo home screen instead of the Unknown route screen. No custom error appears in the console.|The Named routes demo home screen appears. No custom error is printed in the console.|no

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
