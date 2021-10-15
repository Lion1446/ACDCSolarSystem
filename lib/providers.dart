import 'package:flutter/cupertino.dart';

class DataProviders extends ChangeNotifier {
  double batteryPercentage = 90.0;
  double batteryPercentageThreshold = 20.0;
  double batteryVoltage = 12.0;
  double batteryIdleDrainRate = 0.1;
}
