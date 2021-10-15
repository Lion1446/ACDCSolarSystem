import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:solarpumpingsystem/components/battery.dart';
import 'package:solarpumpingsystem/components/environmentVariables.dart';
import 'package:solarpumpingsystem/components/mainControlUnit.dart';
import 'package:solarpumpingsystem/components/reverseOsmosisUnit.dart';
import 'package:solarpumpingsystem/components/soilMoistureSensor.dart';
import 'package:solarpumpingsystem/components/solarPanel.dart';
import 'package:solarpumpingsystem/components/waterPump.dart';
import 'package:solarpumpingsystem/components/waterTank.dart';
import 'package:solarpumpingsystem/providers.dart';
import 'package:solarpumpingsystem/themes.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DataProviders>(
          create: (_) => DataProviders(),
        ),
      ],
      child: MaterialApp(
        title: "AC/DC Solar Pumping System Simulator",
        debugShowCheckedModeBanner: false,
        home: SimulationPage(),
      ),
    );
  }
}

class SimulationPage extends StatefulWidget {
  const SimulationPage({Key? key}) : super(key: key);

  @override
  _SimulationPageState createState() => _SimulationPageState();
}

class _SimulationPageState extends State<SimulationPage> {
  bool pumpSwitch = true;
  bool systemSwitch = true;
  bool reverseOsmosisSwitch = true;
  double batteryPercentage = 99.50;
  double batteryPercentageThreshold = 80.0;
  double batteryIdleDrainRate = 0.01;
  late double solarPanelVoltage;
  double solarPanelMaxVoltage = 12;
  double batteryChargeRate = 2 / 1000;
  double batteryDrainRate = 5 / 1000;

  double waterVolume = 40;
  double waterVolumeThreshold = 90;
  double waterMaxVolume = 100;
  bool waterTankSwitch = true;

  late double batteryVoltage;
  double sunBrightness = 100.0;
  int gearAngle = 0;

  double minSunBrightness = 30.0;
  double soilMoisture = 70;
  double soilMoistureThreshold = 50;
  double soilDryingRate = 5;
  double soilDryingRateThreshold = 20;
  double soilMoisteningRate = 20;
  double soilMoisteningRateThreshold = 10;
  double waterFlowRate = 0.5;
  double roBatteryDrainRate = 5.0;
  bool toWaterTank = true;
  double potableWaterVolume = 0;
  double potableWaterMaxVolume = 0;
  double pipe0 = 0;
  double pipe1 = 0;
  double pipe2 = 0;
  double pipe3 = 0;
  double pipe4 = 0;
  double pipe5 = 0;
  double pipe6 = 0;
  double pipe7 = 0;
  double pipe8 = 0;
  double pipe9 = 0;
  double pipe10 = 0;
  double pipe11 = 0;
  double pipe12 = 0;
  double pipe13 = 0;
  double tankWaterFlow = 0;
  double pipeAdder = 10;

  late TextEditingController batteryPercentageController;
  late TextEditingController batteryVoltageController;
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

  bool done = false;

  @override
  void initState() {
    solarPanelVoltage = solarPanelMaxVoltage * (sunBrightness / 100);
    batteryVoltage = solarPanelVoltage;
    potableWaterMaxVolume = waterMaxVolume;

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      var dataStates = Provider.of<DataProviders>(context);
    });

    roBatteryDrainRateController =
        TextEditingController(text: roBatteryDrainRate.toString());
    waterMaxVolumentController =
        TextEditingController(text: waterMaxVolume.toString());
    waterVolumeThresholdController =
        TextEditingController(text: waterVolumeThreshold.toString());
    waterVolumeController = TextEditingController(text: waterVolume.toString());
    waterFlowRateController =
        TextEditingController(text: waterFlowRate.toString());

    pumpBatteryDrainRateController =
        TextEditingController(text: batteryDrainRate.toString());

    batteryPercentageController =
        TextEditingController(text: batteryPercentage.toString());
    batteryVoltageController =
        TextEditingController(text: batteryVoltage.toString());
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

    waterMaxVolumentController.addListener(() {
      if (waterMaxVolumentController.text.length > 0) {
        setState(() {
          waterMaxVolume = double.parse(waterMaxVolumentController.text);
        });
      } else {
        setState(() {
          waterMaxVolume = 0;
        });
      }
    });

    roBatteryDrainRateController.addListener(() {
      if (roBatteryDrainRateController.text.length > 0) {
        if (double.parse(roBatteryDrainRateController.text) > 100) {
          setState(() {
            waterVolume = 100;
            roBatteryDrainRateController.text = waterMaxVolume.toString();
          });
        } else {
          setState(() {
            waterVolume = double.parse(roBatteryDrainRateController.text);
          });
        }
      } else {
        setState(() {
          waterVolume = 0;
        });
      }
    });

    waterVolumeController.addListener(() {
      if (waterVolumeController.text.length > 0) {
        if (double.parse(waterVolumeController.text) > waterMaxVolume) {
          setState(() {
            waterVolume = waterMaxVolume;
            waterVolumeController.text = waterMaxVolume.toString();
          });
        } else {
          setState(() {
            waterVolume = double.parse(waterVolumeController.text);
          });
        }
      } else {
        setState(() {
          waterVolume = 0;
        });
      }
    });

    waterVolumeThresholdController.addListener(() {
      if (waterVolumeThresholdController.text.length > 0) {
        if (double.parse(waterVolumeThresholdController.text) >
            waterMaxVolume) {
          setState(() {
            waterVolumeThreshold = waterMaxVolume;
            waterVolumeThresholdController.text = waterMaxVolume.toString();
          });
        } else {
          setState(() {
            waterVolumeThreshold =
                double.parse(waterVolumeThresholdController.text);
          });
        }
      } else {
        setState(() {
          waterVolumeThreshold = 0;
        });
      }
    });

    pumpBatteryDrainRateController.addListener(() {
      if (pumpBatteryDrainRateController.text.length > 0) {
        if (double.parse(pumpBatteryDrainRateController.text) > 100) {
          setState(() {
            batteryDrainRate = 100;
            pumpBatteryDrainRateController.text = "100";
          });
        } else {
          setState(() {
            batteryDrainRate =
                double.parse(pumpBatteryDrainRateController.text);
          });
        }
      } else {
        setState(() {
          batteryDrainRate = 0;
        });
      }
    });

    waterFlowRateController.addListener(() {
      if (waterFlowRateController.text.length > 0) {
        if (double.parse(waterFlowRateController.text) > 100) {
          setState(() {
            waterFlowRate = 100;
            waterFlowRateController.text = "100";
          });
        } else {
          setState(() {
            waterFlowRate = double.parse(waterFlowRateController.text);
          });
        }
      } else {
        setState(() {
          waterFlowRate = 0;
        });
      }
    });

    minSunBrightnessController.addListener(() {
      if (minSunBrightnessController.text.length > 0) {
        if (double.parse(minSunBrightnessController.text) > 100) {
          setState(() {
            minSunBrightness = 100;
            minSunBrightnessController.text = "100";
          });
        } else {
          setState(() {
            minSunBrightness = double.parse(minSunBrightnessController.text);
          });
        }
      } else {
        setState(() {
          minSunBrightness = 0;
        });
      }
    });

    solarPanelMaxVoltageController.addListener(() {
      if (solarPanelMaxVoltageController.text.length > 0) {
        if (double.parse(solarPanelMaxVoltageController.text) < 0) {
          setState(() {
            solarPanelMaxVoltage = 0;
            solarPanelMaxVoltageController.text = "0";
          });
        } else {
          setState(() {
            solarPanelMaxVoltage =
                double.parse(solarPanelMaxVoltageController.text);
          });
        }
      } else {
        setState(() {
          solarPanelMaxVoltage = 0;
        });
      }
    });

    solarPanelVoltageController.addListener(() {
      if (solarPanelVoltageController.text.length > 0) {
        if (double.parse(solarPanelVoltageController.text) > 100) {
          setState(() {
            solarPanelVoltage = solarPanelMaxVoltage;
            solarPanelVoltageController.text = "100";
          });
        } else {
          setState(() {
            solarPanelVoltage = double.parse(solarPanelVoltageController.text);
          });
        }
      } else {
        setState(() {
          solarPanelVoltage = 0;
        });
      }
    });

    batteryChargeRateController.addListener(() {
      if (batteryChargeRateController.text.length > 0) {
        if (double.parse(batteryChargeRateController.text) > 100) {
          setState(() {
            batteryChargeRate = 100;
            batteryChargeRateController.text = "100";
          });
        } else {
          setState(() {
            batteryChargeRate = double.parse(batteryChargeRateController.text);
          });
        }
      } else {
        setState(() {
          batteryChargeRate = 0;
        });
      }
    });

    soilMoistureThresholdController.addListener(() {
      if (soilMoistureThresholdController.text.length > 0) {
        if (double.parse(soilMoistureThresholdController.text) > 100) {
          setState(() {
            soilMoistureThreshold = 100;
            soilMoistureThresholdController.text = "100";
          });
        } else {
          setState(() {
            soilMoistureThreshold =
                double.parse(soilMoistureThresholdController.text);
          });
        }
      } else {
        setState(() {
          soilMoistureThreshold = 0;
        });
      }
    });

    soilMoisteningRateController.addListener(() {
      if (soilMoisteningRateController.text.length > 0) {
        if (double.parse(soilMoisteningRateController.text) > 100) {
          setState(() {
            soilMoisteningRate = 100;
            soilMoisteningRateController.text = "100";
          });
        } else {
          setState(() {
            soilMoisteningRate =
                double.parse(soilMoisteningRateController.text);
          });
        }
      } else {
        setState(() {
          soilMoisteningRate = 0;
        });
      }
    });

    soilDryingRateController.addListener(() {
      if (soilDryingRateController.text.length > 0) {
        if (double.parse(soilDryingRateController.text) > 100) {
          setState(() {
            soilDryingRate = 100;
            soilDryingRateController.text = "100";
          });
        } else {
          setState(() {
            soilDryingRate = double.parse(soilDryingRateController.text);
          });
        }
      } else {
        setState(() {
          soilDryingRate = 0;
        });
      }
    });

    soilMoistureController.addListener(() {
      if (soilMoistureController.text.length > 0) {
        if (double.parse(soilMoistureController.text) > 100) {
          setState(() {
            soilMoisture = 100;
            soilMoistureController.text = "100";
          });
        } else {
          setState(() {
            soilMoisture = double.parse(soilMoistureController.text);
          });
        }
      } else {
        setState(() {
          soilMoisture = 0;
        });
      }
    });

    sunBrightnessController.addListener(() {
      if (sunBrightnessController.text.length > 0) {
        if (double.parse(sunBrightnessController.text) > 100) {
          setState(() {
            sunBrightness = 100;
            solarPanelVoltage = solarPanelMaxVoltage * (sunBrightness / 100);
            solarPanelVoltageController.text =
                solarPanelVoltage.toStringAsFixed(2);
            sunBrightnessController.text = "100";
          });
        } else {
          setState(() {
            sunBrightness =
                double.parse(sunBrightnessController.text) + minSunBrightness;
            if (sunBrightness > 100) {
              sunBrightness = 100;
            }
            solarPanelVoltage = solarPanelMaxVoltage * (sunBrightness / 100);
            solarPanelVoltageController.text =
                solarPanelVoltage.toStringAsFixed(2);
          });
        }
      } else {
        setState(() {
          sunBrightness = 0;
          solarPanelVoltage = solarPanelMaxVoltage * (sunBrightness / 100);
          solarPanelVoltageController.text =
              solarPanelVoltage.toStringAsFixed(2);
        });
      }
    });

    batteryPercentageController.addListener(() {
      if (batteryPercentageController.text.length > 0) {
        if (double.parse(batteryPercentageController.text) > 100) {
          setState(() {
            batteryPercentage = 100;
            batteryPercentageController.text = "100";
          });
        } else {
          setState(() {
            batteryPercentage = double.parse(batteryPercentageController.text);
          });
        }
      } else {
        setState(() {
          batteryPercentage = 0;
        });
      }
    });

    batteryVoltageController.addListener(() {
      if (batteryVoltageController.text.length > 0) {
        if (double.parse(batteryVoltageController.text) > solarPanelVoltage) {
          setState(() {
            batteryVoltage = solarPanelVoltage;
            batteryVoltageController.text = "$solarPanelVoltage";
          });
        } else {
          setState(() {
            batteryVoltage = double.parse(batteryVoltageController.text);
          });
        }
      } else {
        setState(() {
          batteryVoltage = 0;
        });
      }
    });

    batteryIdleDrainRateController.addListener(() {
      if (batteryIdleDrainRateController.text.length > 0) {
        if (double.parse(batteryIdleDrainRateController.text) > 100) {
          setState(() {
            batteryIdleDrainRate = 100;
            batteryIdleDrainRateController.text = "100";
          });
        } else {
          setState(() {
            batteryIdleDrainRate =
                double.parse(batteryIdleDrainRateController.text);
          });
        }
      } else {
        setState(() {
          batteryIdleDrainRate = 0;
        });
      }
    });
    Timer.periodic(Duration(milliseconds: 1), (timer) {
      if (waterVolume < waterVolumeThreshold) waterTankSwitch = true;
      if (100 * (waterVolume / waterMaxVolume) >= 20) {
        if (pipe8 < 87) {
          pipeAdder = (pipeAdder).abs();
          pipe8 += pipeAdder;
          if (pipe8 > 87) pipe8 = 87;
        }
      } else {
        if (pipe8 > 0) {
          pipeAdder = -((pipeAdder).abs());
          pipe8 += pipeAdder;
          if (pipe8 < 0) pipe8 = 0;
        }
      }

      if ((pumpSwitch && systemSwitch) &&
          (batteryPercentage >= batteryPercentageThreshold ||
              solarPanelVoltage >= solarPanelMaxVoltage)) {
        setState(() {
          gearAngle += 2;
          pipeAdder = (pipeAdder).abs();
          if (pipe0 < 122) {
            pipe0 += pipeAdder;
            if (pipe0 > 122) pipe0 = 122;
            if (pipe0 < 0) {
              pipe0 = 0;
            }
          } else {
            if (waterTankSwitch) {
              if (toWaterTank) {
                pipeAdder = -((pipeAdder).abs());
                if (pipe7 > 0) {
                  pipe7 += pipeAdder;
                  if (pipe7 <= 0) pipe7 = 0;
                } else {
                  pipe7 = 0;
                  if (pipe6 > 0) {
                    pipe6 += pipeAdder;
                    if (pipe6 < 0) pipe6 = 0;
                  }
                }

                pipeAdder = (pipeAdder).abs();

                if (pipe1 < 168) {
                  pipe1 += pipeAdder;
                  if (pipe1 > 168) pipe1 = 168;
                } else {
                  if (pipe2 < 155.8) {
                    pipe2 += pipeAdder;
                    if (pipe2 > 155.8) pipe2 = 155.8;
                  } else {
                    if (pipe3 < 135) {
                      pipe3 += pipeAdder;
                      if (pipe3 > 135) pipe3 = 135;
                    } else {
                      if (pipe4 < 58) {
                        pipe4 += pipeAdder;
                        if (pipe4 > 58) pipe4 = 58;
                      } else {
                        if (pipe5 < 10) {
                          pipe5 += pipeAdder;
                          if (pipe5 > 10) pipe5 = 10;
                        } else {
                          if (tankWaterFlow < 110) {
                            tankWaterFlow += pipeAdder;
                            if (tankWaterFlow > 200) tankWaterFlow = 200;
                          } else {
                            waterVolume += (waterFlowRate / 100);
                            waterVolumeController.text =
                                waterVolume.toStringAsFixed(2);
                            if (waterVolume >= waterVolumeThreshold)
                              waterTankSwitch = false;
                          }
                        }
                      }
                    }
                  }
                }
              } else {
                tankWaterFlow = 0;
                pipeAdder = -((pipeAdder).abs());

                if (pipe5 > 0) {
                  pipe5 += pipeAdder;
                  if (pipe5 < 0) {
                    pipe5 = 0;
                  }
                } else {
                  if (pipe4 > 0) {
                    pipe4 += pipeAdder;
                    if (pipe4 < 0) {
                      pipe4 = 0;
                    }
                  } else {
                    if (pipe3 > 0) {
                      pipe3 += pipeAdder;
                      if (pipe3 < 0) {
                        pipe3 = 0;
                      }
                    } else {
                      if (pipe2 > 0) {
                        pipe2 += pipeAdder;
                        if (pipe2 < 0) {
                          pipe2 = 0;
                        }
                      } else {
                        if (pipe1 > 0) {
                          pipe1 += pipeAdder;
                          if (pipe1 < 0) {
                            pipe1 = 0;
                          }
                        } else {
                          if (pipe0 > 0) {
                            pipe0 += pipeAdder;
                            if (pipe0 < 0) {
                              pipe0 = 0;
                            }
                          }
                        }
                      }
                    }
                  }
                }
                pipeAdder = (pipeAdder).abs();
                if (pipe6 < 932) {
                  pipe6 += pipeAdder;
                  if (pipe6 > 932) pipe6 = 932;
                } else {
                  if (pipe7 < 10) {
                    pipe7 += pipeAdder;
                    if (pipe7 > 10) pipe7 = 10;
                  }
                }
              }
            } else {
              tankWaterFlow = 0;
              pipeAdder = -((pipeAdder).abs());

              if (pipe5 > 0) {
                pipe5 += pipeAdder;
                if (pipe5 < 0) {
                  pipe5 = 0;
                }
              } else {
                if (pipe4 > 0) {
                  pipe4 += pipeAdder;
                  if (pipe4 < 0) {
                    pipe4 = 0;
                  }
                } else {
                  if (pipe3 > 0) {
                    pipe3 += pipeAdder;
                    if (pipe3 < 0) {
                      pipe3 = 0;
                    }
                  } else {
                    if (pipe2 > 0) {
                      pipe2 += pipeAdder;
                      if (pipe2 < 0) {
                        pipe2 = 0;
                      }
                    } else {
                      if (pipe1 > 0) {
                        pipe1 += pipeAdder;
                        if (pipe1 < 0) {
                          pipe1 = 0;
                        }
                      } else {
                        if (pipe0 > 0) {
                          pipe0 += pipeAdder;
                          if (pipe0 < 0) {
                            pipe0 = 0;
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        });
      } else {
        tankWaterFlow = 0;
        pipeAdder = -((pipeAdder).abs());
        if (pipe7 > 0) {
          pipe7 += pipeAdder;
          if (pipe7 < 0) {
            pipe7 = 0;
          }
        } else {
          if (pipe6 > 0) {
            pipe6 += pipeAdder;
            if (pipe6 < 0) {
              pipe6 = 0;
            }
          }
        }
        if (pipe5 > 0) {
          pipe5 += pipeAdder;
          if (pipe5 < 0) {
            pipe5 = 0;
          }
        } else {
          if (pipe4 > 0) {
            pipe4 += pipeAdder;
            if (pipe4 < 0) {
              pipe4 = 0;
            }
          } else {
            if (pipe3 > 0) {
              pipe3 += pipeAdder;
              if (pipe3 < 0) {
                pipe3 = 0;
              }
            } else {
              if (pipe2 > 0) {
                pipe2 += pipeAdder;
                if (pipe2 < 0) {
                  pipe2 = 0;
                }
              } else {
                if (pipe1 > 0) {
                  pipe1 += pipeAdder;
                  if (pipe1 < 0) {
                    pipe1 = 0;
                  }
                } else {
                  if (pipe0 > 0 && pipe6 == 0) {
                    pipe0 += pipeAdder;
                    if (pipe0 < 0) {
                      pipe0 = 0;
                    }
                  }
                }
              }
            }
          }
        }
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    var _blankFocus = FocusNode();
    // double maxWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(_blankFocus);
        sunBrightnessController.text =
            double.parse(sunBrightnessController.text).toString();
        batteryPercentageController.text =
            double.parse(batteryPercentageController.text).toString();
        batteryVoltageController.text =
            double.parse(batteryVoltageController.text).toString();
        batteryIdleDrainRateController.text =
            double.parse(batteryIdleDrainRateController.text).toString();
        sunBrightnessController.text =
            double.parse(sunBrightnessController.text).toString();
        soilMoistureController.text =
            double.parse(soilMoistureController.text).toString();
        soilDryingRateController.text =
            double.parse(soilDryingRateController.text).toString();
        soilMoisteningRateController.text =
            double.parse(soilMoisteningRateController.text).toString();
      },
      child: Scaffold(
        drawer: Container(
          width: 355,
          child: Drawer(
            child: Container(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Control Panel",
                          style: fonts.header,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Battery(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: EnvironmentVariables(
                        sunBrightnessController: sunBrightnessController,
                        soilMoistureController: soilMoistureController,
                        soilDryingRateController: soilDryingRateController,
                        soilMoisteningRateController:
                            soilMoisteningRateController,
                        sunBrightness: sunBrightness,
                        minSunBrightness: minSunBrightness,
                        soilMoisture: soilMoisture,
                        soilMoistureThreshold: soilMoistureThreshold,
                        soilDryingRate: soilDryingRate,
                        soilDryingRateThreshold: soilDryingRateThreshold,
                        soilMoisteningRate: soilMoisteningRate,
                        soilMoisteningRateThreshold:
                            soilMoisteningRateThreshold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: MainControlUnit(systemSwitch: systemSwitch),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: ReverseOsmosisUnit(
                        reverseOsmosisSwitch: reverseOsmosisSwitch,
                        roBatteryDrainRate: roBatteryDrainRate,
                        roBatteryDrainRateController:
                            roBatteryDrainRateController,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: SoilMoistureSensor(
                          soilMoistureController: soilMoistureController,
                          soilMoisture: soilMoisture,
                          soilMoistureThreshold: soilMoistureThreshold,
                          soilMoistureThresholdController:
                              soilMoistureThresholdController),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: SolarPanel(
                        solarPanelVoltageController:
                            solarPanelVoltageController,
                        batteryChargeRateController:
                            batteryChargeRateController,
                        solarPanelMaxVoltageController:
                            solarPanelMaxVoltageController,
                        minSunBrightnessController: minSunBrightnessController,
                        solarPanelVoltage: solarPanelVoltage,
                        solarPanelMaxVoltage: solarPanelMaxVoltage,
                        minSunBrightness: minSunBrightness,
                        batteryChargeRate: batteryChargeRate,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: WaterPump(
                          waterFlowRateController: waterFlowRateController,
                          batteryDrainRateController:
                              pumpBatteryDrainRateController,
                          pumpSwitch: pumpSwitch,
                          toWaterTank: toWaterTank,
                          batteryDrainRate: batteryDrainRate,
                          waterFlowRate: waterFlowRate),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: WaterTank(
                          waterVolumeController: waterVolumeController,
                          waterVolumeThresholdController:
                              waterVolumeThresholdController,
                          waterMaxVolumentController:
                              waterMaxVolumentController,
                          waterVolume: waterVolume,
                          waterVolumeThreshold: waterVolumeThreshold,
                          waterMaxVolume: waterMaxVolume),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: InkWell(
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    offset: Offset(1, 1),
                                    color: Colors.black.withOpacity(0.1),
                                  )
                                ]),
                            child: Center(
                              child: Icon(Icons.menu),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: (maxHeight - 700) / 2),
                      child: Container(
                        width: 1200,
                        height: 700,
                        child: Stack(
                          children: [
                            Positioned(
                              child:
                                  Image.asset("assets/images/Background.png"),
                            ),
                            Positioned(
                              bottom: 60,
                              child: Container(
                                width: 1200,
                                height: 60,
                                color: Color(0XFFC86000)
                                    .withOpacity(soilMoisture / 100.0),
                              ),
                            ),
                            Positioned(
                              child: ShaderMask(
                                shaderCallback: (rect) {
                                  return LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.yellow, Colors.transparent],
                                  ).createShader(Rect.fromLTRB(
                                      0, 0, rect.width, rect.height));
                                },
                                blendMode: BlendMode.dstIn,
                                child: Container(
                                  width: 1200,
                                  height: 100,
                                  color: Colors.yellow
                                      .withOpacity(sunBrightness / 100.0),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: SvgPicture.asset('assets/images/Main.svg'),
                            ),
                            Positioned(
                              bottom: 94,
                              left: 91,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 10),
                                curve: Curves.linear,
                                width: 5.8,
                                height: pipe0,
                                color: Color(0XFF375E7D),
                              ),
                            ),
                            Positioned(
                              bottom: 216,
                              left: 91,
                              child: AnimatedContainer(
                                decoration: BoxDecoration(
                                  color: Color(0XFF375E7D),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(2),
                                  ),
                                ),
                                duration: Duration(milliseconds: 10),
                                curve: Curves.linear,
                                width: 5.8,
                                height: pipe1,
                              ),
                            ),
                            Positioned(
                              bottom: 378.2,
                              left: 91,
                              child: AnimatedContainer(
                                decoration: BoxDecoration(
                                  color: Color(0XFF375E7D),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(2),
                                    bottomRight: Radius.circular(2),
                                  ),
                                ),
                                duration: Duration(milliseconds: 10),
                                curve: Curves.linear,
                                width: pipe2,
                                height: 5.8,
                              ),
                            ),
                            Positioned(
                              bottom: 378.2,
                              left: 241,
                              child: AnimatedContainer(
                                decoration: BoxDecoration(
                                  color: Color(0XFF375E7D),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(2),
                                    bottomRight: Radius.circular(2),
                                  ),
                                ),
                                duration: Duration(milliseconds: 10),
                                curve: Curves.linear,
                                width: 5.8,
                                height: pipe3,
                              ),
                            ),
                            Positioned(
                              bottom: 507.4,
                              left: 241,
                              child: AnimatedContainer(
                                decoration: BoxDecoration(
                                  color: Color(0XFF375E7D),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(2),
                                    topRight: Radius.circular(2),
                                  ),
                                ),
                                duration: Duration(milliseconds: 10),
                                curve: Curves.linear,
                                width: pipe4,
                                height: 5.8,
                              ),
                            ),
                            Positioned(
                              bottom: 504,
                              left: 293.2,
                              child: AnimatedOpacity(
                                duration: Duration(milliseconds: 100),
                                opacity: pipe5 != 0 ? 1.0 : 0.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0XFF375E7D),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(2),
                                      topRight: Radius.circular(2),
                                    ),
                                  ),
                                  width: 5.8,
                                  height: 6,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 490,
                              left: 294,
                              child: Transform.rotate(
                                alignment: FractionalOffset.bottomCenter,
                                angle: -math.pi,
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 100),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0XFF375E7D),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(2),
                                        topRight: Radius.circular(2),
                                      ),
                                    ),
                                    width: 5.8,
                                    height: tankWaterFlow,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 380,
                              left: 250,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 100),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0XFF375E7D),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  width: 95,
                                  height: 100 * (waterVolume / waterMaxVolume),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 394,
                              left: 354,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 100),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0XFF375E7D),
                                  ),
                                  width: pipe8,
                                  height: 5.0,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 336,
                              left: 523,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 100),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0XFF58B5D2),
                                    borderRadius: BorderRadius.only(
                                      // bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(2),
                                    ),
                                  ),
                                  width: 15,
                                  height: 5.0,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 336,
                              left: 533,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 100),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0XFF58B5D2),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(2),
                                      bottomRight: Radius.circular(2),
                                    ),
                                  ),
                                  width: 5.0,
                                  height: 113,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 445,
                              left: 533,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 100),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0XFF58B5D2),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(2),
                                      topLeft: Radius.circular(2),
                                    ),
                                  ),
                                  width: 57,
                                  height: 5,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 448,
                              left: 585,
                              child: Transform.rotate(
                                alignment: FractionalOffset.bottomCenter,
                                angle: -math.pi,
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 100),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0XFF58B5D2),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(2),
                                        topRight: Radius.circular(2),
                                      ),
                                    ),
                                    width: 5.8,
                                    height: 6,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 332,
                              left: 645,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 100),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0XFF58B5D2),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(2),
                                      topLeft: Radius.circular(2),
                                    ),
                                  ),
                                  width: 5,
                                  height: 5,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 338,
                              left: 673,
                              child: Transform.rotate(
                                alignment: FractionalOffset.bottomCenter,
                                angle: -math.pi,
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 100),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0XFF58B5D2),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(2),
                                      ),
                                    ),
                                    width: 5.8,
                                    height: 172,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 318,
                              left: 541,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 100),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0XFF58B5D2),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  width: 95,
                                  height: 100 *
                                      (potableWaterVolume /
                                          potableWaterMaxVolume),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 130,
                              left: 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0XFF375E7D),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(2),
                                    topRight: Radius.circular(2),
                                  ),
                                ),
                                width: pipe6,
                                height: 5.8,
                              ),
                            ),
                            Positioned(
                              bottom: 130,
                              left: 1030,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 100),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0XFF375E7D),
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(2),
                                    ),
                                  ),
                                  width: 5.8,
                                  height: pipe7,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 160,
                              left: 65,
                              child: RotationTransition(
                                  turns:
                                      AlwaysStoppedAnimation(gearAngle / 360),
                                  child: SvgPicture.asset(
                                      "assets/images/Gear.svg")),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: Container(
                                width: 1200,
                                height: 700,
                                color: Colors.black.withOpacity(
                                    (0.4 - (sunBrightness / 100.0) < 0)
                                        ? 0
                                        : 0.4 - (sunBrightness / 100.0)),
                              ),
                            ),
                            Positioned(
                              bottom: 330,
                              left: 656,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: grayButton,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 122,
                              left: 81,
                              child: Transform.rotate(
                                angle: toWaterTank ? -math.pi / 2 : 0,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      toWaterTank = !toWaterTank;
                                    });
                                  },
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 195,
                              left: 515,
                              child: Container(
                                width: 60,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          pumpSwitch = !pumpSwitch;
                                        });
                                      },
                                      child: Container(
                                        width: 15,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          color: pumpSwitch && systemSwitch
                                              ? Colors.red[700]
                                              : grayButton,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          systemSwitch = !systemSwitch;
                                        });
                                      },
                                      child: Container(
                                        width: 15,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          color: systemSwitch
                                              ? Colors.red[700]
                                              : grayButton,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          reverseOsmosisSwitch =
                                              !reverseOsmosisSwitch;
                                        });
                                      },
                                      child: Container(
                                        width: 15,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          color: reverseOsmosisSwitch &&
                                                  systemSwitch
                                              ? Colors.red[700]
                                              : grayButton,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
