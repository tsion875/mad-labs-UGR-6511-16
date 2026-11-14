| Widget             | Stateless or stateful? | Why                                                                              |
| ------------------ | ---------------------- | -------------------------------------------------------------------------------- |
| CampusCompanionApp | Stateless              | It does not own a value that changes while it is on screen.                      |
| HomeScreen         | Stateful               | It owns \_checkIns and \_showLogger, which change while the screen is displayed. |
| LifecycleLogger    | Stateful               | It tracks lifecycle changes while it is mounted and removed.                     |

Step Prediction (callbacks in order; card text)

1. Turn the switch on initState → didChangeDependencies → build. Card: Check-ins: 0 — built 1 time(s)
2. Press the FAB three times didUpdateWidget → build (repeated 3 times). Card: Check-ins: 3 — built 4 time(s)
3. Turn the switch off dispose. Card disappears.
4. Turn the switch on again initState → didChangeDependencies → build. Card: Check-ins: 3 — built 1 time(s)

## Actual observations

| Step                     | Actual callbacks observed                 | Actual card text               | Same as prediction? |
| ------------------------ | ----------------------------------------- | ------------------------------ | ------------------- |
| 1. Turn switch on        | initState → didChangeDependencies → build | Check-ins: 0 — built 1 time(s) | Yes                 |
| 2. Press FAB three times | didUpdateWidget → build (3 times)         | Check-ins: 3 — built 4 time(s) | Yes                 |
| 3. Turn switch off       | dispose                                   | Card disappears                | Yes                 |
| 4. Turn switch on again  | initState → didChangeDependencies → build | Check-ins: 3 — built 1 time(s) | Yes                 |
