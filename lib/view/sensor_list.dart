import 'package:flutter/cupertino.dart';
import 'package:sensor_graph/sensor/accelerometer_sensor.dart';
import 'package:sensor_graph/sensor/gyroscope_sensor.dart';
import 'package:sensor_graph/sensor/magnetometer_sensor.dart';
import 'package:sensor_graph/sensor/measurable_sensor.dart';
import 'package:sensor_graph/sensor/motion_sensor.dart';
import 'package:sensor_graph/view/sensor_graph.dart';

class SensorList extends StatelessWidget {
  const SensorList({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
          middle: Text('Sensors'),
          backgroundColor: CupertinoColors.lightBackgroundGray),
      child: CupertinoListSection.insetGrouped(
        margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        children: <Widget>[
          SensorTile(
              text: 'Motion',
              sensor: MotionSensor(),
              color: CupertinoColors.systemPurple),
          SensorTile(
              text: 'Accelerometer',
              sensor: AccelerometerSensor(),
              color: CupertinoColors.systemOrange),
          SensorTile(
              text: 'Gyroscope',
              sensor: GyroscopeSensor(),
              color: CupertinoColors.systemYellow),
          SensorTile(
              text: 'Magnetometer',
              sensor: MagnetometerSensor(),
              color: CupertinoColors.systemGreen),
        ],
      ),
    );
  }
}

class SensorTile extends StatelessWidget {
  const SensorTile(
      {super.key,
      required this.text,
      required this.sensor,
      required this.color});

  final String text;
  final MeasurableSensor sensor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile.notched(
      title: Text(text),
      leading: Container(
        width: double.infinity,
        height: double.infinity,
        color: color,
      ),
      trailing: const CupertinoListTileChevron(),
      onTap: () => Navigator.of(context).push(
        CupertinoPageRoute<void>(builder: (BuildContext context) {
          return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                middle: Text(text),
                backgroundColor: color,
              ),
              resizeToAvoidBottomInset: false,
              child: SingleChildScrollView(
                  child: SensorGraph(text: text, sensor: sensor)));
        }),
      ),
    );
  }
}
