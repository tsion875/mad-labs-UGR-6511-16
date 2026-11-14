import 'package:flutter/material.dart';

import '../widgets/lifecycle_logger.dart';

/// Home screen.
// TODO(lab): Task 2 — decide whether HomeScreen must be stateless or
// stateful (write the reason in lifecycle.md), then make it:
//  - show 'Check-ins today: N' (titleLarge text style)
//  - have a FloatingActionButton (Icons.add) that adds one to N
//  - have a SwitchListTile 'Show lifecycle logger'
//  - show LifecycleLogger(label: 'Check-ins: N') only while the switch
//    is on
// The tests in test/screens/home_screen_test.dart describe the behaviour.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _checkIns = 0;
  bool _showLogger = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2)).then((_) {
      if (!mounted) return;

      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Campus Companion')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Welcome to Campus Companion'),

            if (_loading)
              const Center(child: CircularProgressIndicator())
            else
              Text(
                'Check-ins today: $_checkIns',
                style: Theme.of(context).textTheme.titleLarge,
              ),

            SwitchListTile(
              title: const Text('Show lifecycle logger'),
              value: _showLogger,
              onChanged: (value) {
                setState(() {
                  _showLogger = value;
                });
              },
            ),

            if (_showLogger && !_loading)
              LifecycleLogger(label: 'Check-ins: $_checkIns'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _checkIns++;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
