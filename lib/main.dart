import 'package:flutter/cupertino.dart';
import 'package:sensor_graph/view/sensor_list.dart';

/// Flutter code sample for inset [CupertinoListSection] and [CupertinoListTile].

void main() => runApp(const SensorGraphApp());

class SensorGraphApp extends StatelessWidget {
  const SensorGraphApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: SensorList(),
    );
  }
}
