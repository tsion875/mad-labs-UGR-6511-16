# Settings Design Decisions

1. **Entry point:** Settings will be opened from the navigation drawer. This makes Settings accessible from every tab without using one of the main bottom navigation destinations.

2. **Navigator:** Settings will be placed on the root navigator. This allows the Settings screen to appear above the tab navigation and hide the bottom navigation bar. Using `context.push` allows the user to return to the same tab using Back.
