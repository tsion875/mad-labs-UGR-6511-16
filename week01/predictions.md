Step| Prediction: what will you see?| What you saw |Same?
a. | The greeting will change|The greeting changed to my native language immediately after hot reload. The app did not restart.| yes
b. | it will still display amharic greeting |The app still displayed the Amharic greeting after hot reload.| yes
c. |The app will restart and display the Placeholder widget instead of the Amharic greeting|After hot restart, the app displayed the Placeholder widget (a large X) instead of the Amharic greeting.| yes
selfcheck: Hot reload changed the running app without restarting it. It preserves the app's current state and does not rerun main(). while hot restart restarts the app from the beginning, reruns main(), and resets the app's state.
