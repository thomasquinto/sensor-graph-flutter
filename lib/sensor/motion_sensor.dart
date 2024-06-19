// ignore_for_file: deprecated_member_use

import 'package:sensor_graph/sensor/measurable_sensor.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MotionSensor implements MeasurableSensor {
  MotionSensor()
      : sensorType = SensorType.motion,
        super();

  @override
  SensorType sensorType;

  @override
  void startListening(Function onValues) {
    userAccelerometerEvents.listen(
      (UserAccelerometerEvent event) {
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
    userAccelerometerEvents.listen(null);
  }
}
