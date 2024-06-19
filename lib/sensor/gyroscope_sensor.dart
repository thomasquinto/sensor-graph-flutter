// ignore_for_file: deprecated_member_use

import 'package:sensor_graph/sensor/measurable_sensor.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GyroscopeSensor implements MeasurableSensor {
  GyroscopeSensor()
      : sensorType = SensorType.gyroscope,
        super();

  @override
  SensorType sensorType;

  @override
  void startListening(Function onValues) {
    gyroscopeEvents.listen(
      (GyroscopeEvent event) {
        onValues(event.x, event.y, event.z);
      },
      onError: (error) {
        // Logic to handle error
        // Needed for Android in case sensor is not available
      },
      cancelOnError: true,
    );
  }

  @override
  void stopListening() {
    gyroscopeEvents.listen(null);
  }
}
