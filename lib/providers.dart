import 'package:flutter/cupertino.dart';

class DataProviders extends ChangeNotifier {
  double batteryPercentage = 90.0;
  double batteryPercentageThreshold = 20.0;
  double batteryVoltage = 12.0;
  double batteryIdleDrainRate = 0.1;
  double sunBrightness = 100.0;
  double minSunBrightness = 70.0;
  double soilMoisture = 40.0;
  double soilMoistureThreshold = 50.0;
  double soilDryingRate = 1.0;
  double soilDryingRateThreshold = 1.0;
  double soilMoisteningRate = 10.0;
  double soilMoisteningRateThreshold = 1.0;

  bool systemSwitch = true;

  bool reverseOsmosisSwitch = true;
  double roBatteryDrainRate = 1.0;
  double solarPanelVoltage = 12;
  double solarPanelMaxVoltage = 12;
  double batteryChargeRate = 1.0;
  bool roSwitch = true;

  bool pumpSwitch = true;
  double waterFlowRate = 50.0;
  int toWaterTank = 0;
  bool waterTankSwitch = false;
  double pumpBatteryDrainRate = 2.0;

  double waterVolume = 0.0;
  double maxWaterVolume = 100.0;
  double waterVolumeThreshold = 90.0;

  double potableWaterVolume = 0.0;
  double maxPotableWaterVolume = 100.0;

  bool toHousehold = false;
  bool sprinklerSwitch = true;

  late TextEditingController batteryPercentageController;
  late TextEditingController batteryIdleDrainRateController;
  late TextEditingController sunBrightnessController;
  late TextEditingController soilMoistureController;
  late TextEditingController soilMoistureThresholdController;
  late TextEditingController soilDryingRateController;
  late TextEditingController soilMoisteningRateController;
  late TextEditingController solarPanelVoltageController;
  late TextEditingController batteryChargeRateController;
  late TextEditingController solarPanelMaxVoltageController;
  late TextEditingController minSunBrightnessController;
  late TextEditingController waterFlowRateController;
  late TextEditingController pumpBatteryDrainRateController;
  late TextEditingController waterVolumeController;
  late TextEditingController waterVolumeThresholdController;
  late TextEditingController waterMaxVolumentController;
  late TextEditingController roBatteryDrainRateController;

  reset() {
    batteryPercentage = 90.0;
    batteryPercentageThreshold = 20.0;
    batteryVoltage = 12.0;
    batteryIdleDrainRate = 0.1;
    sunBrightness = 100.0;
    minSunBrightness = 70.0;
    soilMoisture = 40.0;
    soilMoistureThreshold = 50.0;
    soilDryingRate = 1.0;
    soilDryingRateThreshold = 1.0;
    soilMoisteningRate = 10.0;
    soilMoisteningRateThreshold = 1.0;

    systemSwitch = true;

    reverseOsmosisSwitch = true;
    roBatteryDrainRate = 1.0;
    solarPanelVoltage = 12;
    solarPanelMaxVoltage = 12;
    batteryChargeRate = 1.0;
    roSwitch = true;

    pumpSwitch = true;
    waterFlowRate = 50.0;
    toWaterTank = 0;
    waterTankSwitch = false;
    pumpBatteryDrainRate = 2.0;

    waterVolume = 0.0;
    maxWaterVolume = 100.0;
    waterVolumeThreshold = 90.0;

    potableWaterVolume = 0.0;
    maxPotableWaterVolume = 100.0;

    toHousehold = false;
    sprinklerSwitch = true;
  }

  setup() {
    batteryVoltage = solarPanelMaxVoltage;
    batteryPercentageController =
        TextEditingController(text: batteryPercentage.toString());
    batteryIdleDrainRateController =
        TextEditingController(text: batteryIdleDrainRate.toString());
    sunBrightnessController =
        TextEditingController(text: sunBrightness.toString());
    soilMoistureController =
        TextEditingController(text: soilMoisture.toString());
    soilMoistureThresholdController =
        TextEditingController(text: soilMoistureThreshold.toString());
    soilDryingRateController =
        TextEditingController(text: soilDryingRate.toString());
    soilMoisteningRateController =
        TextEditingController(text: soilMoisteningRate.toString());
    solarPanelVoltageController =
        TextEditingController(text: solarPanelVoltage.toString());
    batteryChargeRateController =
        TextEditingController(text: batteryChargeRate.toString());
    solarPanelMaxVoltageController =
        TextEditingController(text: solarPanelMaxVoltage.toString());
    minSunBrightnessController =
        TextEditingController(text: minSunBrightness.toString());
    waterFlowRateController =
        TextEditingController(text: waterFlowRate.toString());
    pumpBatteryDrainRateController =
        TextEditingController(text: pumpBatteryDrainRate.toString());
    waterVolumeController = TextEditingController(text: waterVolume.toString());
    waterVolumeThresholdController =
        TextEditingController(text: waterVolumeThreshold.toString());
    waterMaxVolumentController =
        TextEditingController(text: maxWaterVolume.toString());
    roBatteryDrainRateController =
        TextEditingController(text: roBatteryDrainRate.toString());

    batteryPercentageController.addListener(() {
      if (batteryPercentageController.text.isNotEmpty) {
        double data = double.parse(batteryPercentageController.text);
        if (data > 100) {
          data = 100;
          batteryPercentageController.text = "100";
        }
        if (data < 0) data = 0;
        batteryPercentage = data;
      } else {
        batteryPercentage = 0.0;
        batteryPercentageController.text = "0";
      }
      notifyListeners();
    });

    batteryIdleDrainRateController.addListener(() {
      if (batteryIdleDrainRateController.text.isNotEmpty) {
        double data = double.parse(batteryIdleDrainRateController.text);
        if (data > 100) {
          data = 100;
          batteryIdleDrainRateController.text = "100";
        }
        if (data < 0) data = 0;
        batteryIdleDrainRate = data;
      } else {
        batteryIdleDrainRate = 0.0;
        batteryIdleDrainRateController.text = "0";
      }
      notifyListeners();
    });

    sunBrightnessController.addListener(() {
      if (sunBrightnessController.text.isNotEmpty) {
        double data = double.parse(sunBrightnessController.text);
        if (data > 100) {
          data = 100;
          sunBrightnessController.text = "100";
        }
        if (data < 0) data = 0;
        sunBrightness = data;
        if (sunBrightness >= minSunBrightness) {
          solarPanelVoltage = solarPanelMaxVoltage;
        } else {
          solarPanelVoltage = solarPanelMaxVoltage * (sunBrightness / 100);
        }
      } else {
        sunBrightness = 0.0;
        sunBrightnessController.text = "0";
      }
      notifyListeners();
    });

    soilMoistureController.addListener(() {
      if (soilMoistureController.text.isNotEmpty) {
        double data = double.parse(soilMoistureController.text);
        if (data > 100) {
          data = 100;
          soilMoistureController.text = "100";
          soilMoisture = 100;
        }
        if (data < 0) data = 0;
        soilMoisture = data;
      } else {
        soilMoisture = 0.0;
        soilMoistureController.text = "0";
      }
      notifyListeners();
    });

    soilMoistureThresholdController.addListener(() {
      if (soilMoistureThresholdController.text.isNotEmpty) {
        double data = double.parse(soilMoistureThresholdController.text);
        if (data > 100) {
          data = 100;
          soilMoistureThresholdController.text = "100";
        }
        if (data < 0) data = 0;
        soilMoistureThreshold = data;
      } else {
        soilMoistureThreshold = 0.0;
        soilMoistureThresholdController.text = "0";
      }
      notifyListeners();
    });

    soilDryingRateController.addListener(() {
      if (soilDryingRateController.text.isNotEmpty) {
        double data = double.parse(soilDryingRateController.text);
        if (data > 100) {
          data = 100;
          soilDryingRateController.text = "100";
        }
        if (data < 0) data = 0;
        soilDryingRate = data;
      } else {
        soilDryingRate = 0.0;
        soilDryingRateController.text = "0";
      }
      notifyListeners();
    });

    soilMoisteningRateController.addListener(() {
      if (soilMoisteningRateController.text.isNotEmpty) {
        double data = double.parse(soilMoisteningRateController.text);
        if (data > 100) {
          data = 100;
          soilMoisteningRateController.text = "100";
        }
        if (data < 0) data = 0;
        soilMoisteningRate = data;
      } else {
        soilMoisteningRate = 0.0;
        soilMoisteningRateController.text = "0";
      }
      notifyListeners();
    });

    batteryChargeRateController.addListener(() {
      if (batteryChargeRateController.text.isNotEmpty) {
        double data = double.parse(batteryChargeRateController.text);
        if (data < 0) data = 0;
        batteryChargeRate = data;
      } else {
        batteryChargeRate = 0.0;
        batteryChargeRateController.text = "0";
      }
      notifyListeners();
    });

    solarPanelMaxVoltageController.addListener(() {
      if (solarPanelMaxVoltageController.text.isNotEmpty) {
        double data = double.parse(solarPanelMaxVoltageController.text);
        if (data < 0) data = 0;
        solarPanelMaxVoltage = data;
      } else {
        solarPanelMaxVoltage = 0.0;
        solarPanelMaxVoltageController.text = "0";
      }
      notifyListeners();
    });

    minSunBrightnessController.addListener(() {
      if (soilMoisteningRateController.text.isNotEmpty) {
        double data = double.parse(minSunBrightnessController.text);
        if (data > 100) {
          data = 100;
          soilMoisteningRateController.text = "100";
        }
        if (data < 0) data = 0;
        minSunBrightness = data;
      } else {
        minSunBrightness = 0.0;
        minSunBrightnessController.text = "0";
      }
      notifyListeners();
    });

    waterFlowRateController.addListener(() {
      if (waterFlowRateController.text.isNotEmpty) {
        double data = double.parse(waterFlowRateController.text);
        if (data < 0) data = 0;
        waterFlowRate = data;
      } else {
        waterFlowRate = 0.0;
        waterFlowRateController.text = "0";
      }
      notifyListeners();
    });

    pumpBatteryDrainRateController.addListener(() {
      if (pumpBatteryDrainRateController.text.isNotEmpty) {
        double data = double.parse(pumpBatteryDrainRateController.text);
        if (data > 100) data = 100;
        if (data < 0) data = 0;
        pumpBatteryDrainRate = data;
      } else {
        pumpBatteryDrainRate = 0.0;
        pumpBatteryDrainRateController.text = "0";
      }
      notifyListeners();
    });

    waterVolumeController.addListener(() {
      if (waterVolumeController.text.isNotEmpty) {
        double data = double.parse(waterVolumeController.text);
        if (data > maxWaterVolume) data = maxWaterVolume;
        waterVolume = data;
      } else {
        waterVolume = 0.0;
        waterVolumeController.text = "0";
      }
      notifyListeners();
    });

    waterVolumeThresholdController.addListener(() {
      if (waterVolumeThresholdController.text.isNotEmpty) {
        double data = double.parse(waterVolumeThresholdController.text);
        if (data > maxWaterVolume) {
          data = maxWaterVolume;
          waterVolumeThresholdController.text = maxWaterVolume.toString();
        }
        if (data < 0) data = 0;
        waterVolumeThreshold = data;
      } else {
        waterVolumeThreshold = 0.0;
        waterVolumeThresholdController.text = "0";
      }
      notifyListeners();
    });

    waterMaxVolumentController.addListener(() {
      if (waterMaxVolumentController.text.isNotEmpty) {
        double data = double.parse(waterMaxVolumentController.text);
        if (data < 0) data = 0;
        maxWaterVolume = data;
      } else {
        maxWaterVolume = 0.0;
        waterMaxVolumentController.text = "0";
      }
      notifyListeners();
    });

    roBatteryDrainRateController.addListener(() {
      if (roBatteryDrainRateController.text.isNotEmpty) {
        double data = double.parse(roBatteryDrainRateController.text);
        if (data > 100) {
          data = 100;
          roBatteryDrainRateController.text = "100";
        }
        if (data < 0) data = 0;
        roBatteryDrainRate = data;
      } else {
        roBatteryDrainRate = 0.0;
        roBatteryDrainRateController.text = "0";
      }
      notifyListeners();
    });
  }

  setToWaterTank(int val) {
    toWaterTank = val;
    notifyListeners();
  }

  setSystemSwitch(bool val) {
    systemSwitch = val;
    notifyListeners();
  }

  setPumpSwitch(bool val) {
    pumpSwitch = val;
    notifyListeners();
  }

  setROSwitch(bool val) {
    roSwitch = val;
    notifyListeners();
  }

  setToHousehold(bool val) {
    toHousehold = val;
    notifyListeners();
  }
}
