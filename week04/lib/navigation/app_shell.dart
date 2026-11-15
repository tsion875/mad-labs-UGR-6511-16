
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'router.dart'; // ignore: unused_import — used from Task 5 on

/// The persistent frame around the four main sections: an AppBar, a
/// Drawer with secondary destinations, and a bottom NavigationBar.
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  // TODO(lab): Task 3 — titles for all four branches, in branch order.
  static const _titles = ['Events', 'Notes', 'Lost & found', 'Profile'];

  void _goBranch(int index) {
    // Tapping the current tab again pops that branch to its first route.
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[navigationShell.currentIndex])),
      drawer: const AppDrawer(),
      body: navigationShell,
      // NavigationBar is the Material 3 successor of BottomNavigationBar.
      // The older widget still exists; the API is nearly identical
      // (items/currentIndex/onTap vs destinations/selectedIndex/
      // onDestinationSelected).
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _goBranch,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.event_outlined),
            selectedIcon: Icon(Icons.event),
            label: 'Events',
          ),
          NavigationDestination(
            icon: Icon(Icons.note_outlined),
            selectedIcon: Icon(Icons.note),
            label: 'Notes',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Lost & found',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

/// Secondary destinations. A Drawer is a Scaffold slot; the ListView inside
/// scrolls if the list outgrows a small screen.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: const Align(
              alignment: Alignment.bottomLeft,
              child: Text('Campus Companion', style: TextStyle(fontSize: 22)),
            ),
          ),
          // TODO(lab): Task 5 — ListTiles for 'Check-in' and 'About'.
        ],
      ),
    );
  }
}


