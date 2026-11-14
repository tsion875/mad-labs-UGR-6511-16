Step |Prediction: what will you see? | What you saw| Same?
a. Add Image.asset('assets/images/logo.png') to the stub ProfileScreen, press R (hot restart), switch to Profile|I predict the logo will not appear. An error message will appear in the console saying the asset cannot be found or loaded.|Chrome showed a 404 error for assets/assets/images/logo.png.|yes
b. Declare the folder in pubspec.yaml (step 3 below), then press R |I predict the logo will appear correctly on the Profile screen.|Logo appeared successfully.|yes

I predict that if you remove the Expanded around the details and the title is very long, title and other details will compete for horizontal space with the date box and Free chip. The card may overflow or display a layout error.

task 3: Step | Prediction | What you saw | Same?
a. Drag the Chrome window from narrower than 600 px to wider |The events feed will change from a vertical list to a grid when the width reaches 600 px.|The feed changed from a vertical list to a grid at 600 px.|yes
b. Change mainAxisExtent to 120, hot reload, look at a wide window |Grid cards will become shorter, and some content may be clipped or overflow because the available height is smaller.|The grid cards became shorter and more compact after changing the height to 120|yes
c. With 120, run flutter test test/screens/events_screen_test.dart: which test fails, and with which message?|The test checking the grid card height or content layout may fail because the cards are too short.|wide width uses a GridView failed. Flutter reported A RenderFlex overflowed by 36 pixels on the bottom (and other overflows of 40 and 56 pixels).|yes
