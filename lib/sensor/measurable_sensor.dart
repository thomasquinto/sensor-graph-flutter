enum SensorType { motion, accelerometer, gyroscope, magnetometer }

abstract class MeasurableSensor {
  MeasurableSensor(this.sensorType);

  SensorType sensorType;

  void startListening(Function onValues);

  void stopListening();
}
