import 'package:flutter/material.dart';

/// A widget that prints every lifecycle callback so you can watch the
/// StatefulWidget lifecycle in the console.
// TODO(lab): Task 3 — convert this to a StatefulWidget whose State:
//  - keeps an int _buildCount
//  - overrides initState, didChangeDependencies, didUpdateWidget, build
//    and dispose, each calling debugPrint('[LifecycleLogger] <name>')
//  - build() increments _buildCount and returns a Card containing
//    Text('${widget.label} — built $_buildCount time(s)')
// Remember: super.initState() first, super.dispose() last.
class LifecycleLogger extends StatefulWidget {
  const LifecycleLogger({required this.label, super.key});

  final String label;

  @override
  State<LifecycleLogger> createState() => _LifecycleLoggerState();
}

class _LifecycleLoggerState extends State<LifecycleLogger> {
  int _buildCount = 0;

  @override
  void initState() {
    super.initState();
    debugPrint('[LifecycleLogger] initState: ${widget.label}');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('[LifecycleLogger] didChangeDependencies');
  }

  @override
  void didUpdateWidget(covariant LifecycleLogger oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint(
      '[LifecycleLogger] didUpdateWidget: '
      '${oldWidget.label} → ${widget.label}',
    );
  }

  @override
  Widget build(BuildContext context) {
    _buildCount++;
    debugPrint('[LifecycleLogger] build');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text('${widget.label} — built $_buildCount time(s)'),
      ),
    );
  }

  @override
  void dispose() {
    debugPrint('[LifecycleLogger] dispose');
    super.dispose();
  }
}
