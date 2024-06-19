import 'package:flutter/cupertino.dart';
import 'package:sensor_graph/sensor/measurable_sensor.dart';

import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class SensorGraph extends StatefulWidget {
  const SensorGraph({super.key, required this.text, required this.sensor});

  final String text;
  final MeasurableSensor sensor;

  @override
  State<SensorGraph> createState() => _SensorGraphState();
}

class _SensorGraphState extends State<SensorGraph> {
  final Color xColor = CupertinoColors.activeBlue;
  final Color yColor = CupertinoColors.activeGreen;
  final Color zColor = CupertinoColors.activeOrange;

  final limitCount = 100;
  final xPoints = <FlSpot>[];
  final yPoints = <FlSpot>[];
  final zPoints = <FlSpot>[];

  double xValue = 0;
  double step = 1.0;
  List<double> allValues = <double>[];

  @override
  void initState() {
    super.initState();

    widget.sensor.startListening((double x, double y, double z) {
      if (!mounted) return;

      while (xPoints.length > limitCount) {
        xPoints.removeAt(0);
        yPoints.removeAt(0);
        zPoints.removeAt(0);

        for (int i = 0; i < 3; i++) {
          allValues.removeAt(0);
        }
      }

      setState(() {
        xPoints.add(FlSpot(xValue, x));
        yPoints.add(FlSpot(xValue, y));
        zPoints.add(FlSpot(xValue, z));
      });

      allValues.add(x);
      allValues.add(y);
      allValues.add(z);

      xValue += step;
    });
  }

  @override
  Widget build(BuildContext context) {
    return xPoints.isNotEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1.5,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: LineChart(
                    LineChartData(
                      minY: allValues.reduce(min),
                      maxY: allValues.reduce(max),
                      minX: xPoints.first.x,
                      maxX: xPoints.last.x,
                      lineTouchData: const LineTouchData(enabled: false),
                      clipData: const FlClipData.all(),
                      gridData: const FlGridData(
                        show: false,
                        drawVerticalLine: false,
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        xLine(xPoints),
                        yLine(yPoints),
                        zLine(zPoints),
                      ],
                      titlesData: const FlTitlesData(
                        show: false,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        : Container();
  }

  LineChartBarData xLine(List<FlSpot> points) {
    return LineChartBarData(
      spots: points,
      dotData: const FlDotData(
        show: false,
      ),
      gradient: LinearGradient(
        colors: [xColor.withOpacity(0), xColor],
        stops: const [0.1, 1.0],
      ),
      barWidth: 4,
      isCurved: true,
    );
  }

  LineChartBarData yLine(List<FlSpot> points) {
    return LineChartBarData(
      spots: points,
      dotData: const FlDotData(
        show: false,
      ),
      gradient: LinearGradient(
        colors: [yColor.withOpacity(0), yColor],
        stops: const [0.1, 1.0],
      ),
      barWidth: 4,
      isCurved: true,
    );
  }

  LineChartBarData zLine(List<FlSpot> points) {
    return LineChartBarData(
      spots: points,
      dotData: const FlDotData(
        show: false,
      ),
      gradient: LinearGradient(
        colors: [yColor.withOpacity(0), zColor],
        stops: const [0.1, 1.0],
      ),
      barWidth: 4,
      isCurved: true,
    );
  }

  @override
  void dispose() {
    widget.sensor.stopListening();
    super.dispose();
  }
}
