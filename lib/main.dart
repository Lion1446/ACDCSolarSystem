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
  bool played = false;
  double gearAngle = 0.0;
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
  double pipe14 = 0;
  double tankWaterFlow = 0;
  double potableTankWaterFlow = 0;
  double pipeAdder = 10;
  late DataProviders dataStates;
  double pipeWidth = 5.0;
  double sprinkle = -1;

  void restart() {
    played = false;
    dataStates.reset();
    gearAngle = 0.0;
    pipe0 = 0;
    pipe1 = 0;
    pipe2 = 0;
    pipe3 = 0;
    pipe4 = 0;
    pipe5 = 0;
    pipe6 = 0;
    pipe7 = 0;
    pipe8 = 0;
    pipe9 = 0;
    pipe10 = 0;
    pipe11 = 0;
    pipe12 = 0;
    pipe13 = 0;
    pipe14 = 0;
    tankWaterFlow = 0;
    potableTankWaterFlow = 0;
    pipeAdder = 10;
    pipeWidth = 5.0;
    sprinkle = -1;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      dataStates = Provider.of<DataProviders>(context, listen: false);
      dataStates.setup();
    });
    Timer.periodic(Duration(milliseconds: 1), (timer) {
      dataStates.batteryPercentage -= (dataStates.batteryIdleDrainRate / 100);
      if (dataStates.sunBrightness >= dataStates.minSunBrightness) {
        dataStates.batteryPercentage += (dataStates.batteryChargeRate / 100);
      }
      dataStates.soilMoisture -= dataStates.soilDryingRate / 100;
      if (dataStates.toHousehold &&
          dataStates.potableWaterVolume / dataStates.maxPotableWaterVolume >=
              0.2) {
        dataStates.potableWaterVolume -= dataStates.waterFlowRate / 1000;
        if (pipe13 < 5) {
          pipe13 += pipeAdder;
          if (pipe13 > 5) pipe13 = 5;
        } else {
          if (pipe14 < 172) {
            pipe14 += pipeAdder;
            if (pipe14 > 172) pipe14 = 172;
          }
        }
      } else {
        if (pipe14 > 0) {
          pipe14 -= pipeAdder;
          if (pipe14 < 0) pipe14 = 0;
        } else {
          if (pipe13 > 0) {
            pipe13 -= pipeAdder;
            if (pipe13 < 0) pipe13 = 0;
          }
        }
      }
      if (dataStates.sunBrightness < dataStates.minSunBrightness &&
          dataStates.batteryPercentage <
              dataStates.batteryPercentageThreshold) {
        dataStates.systemSwitch = false;
        sprinkle = -1;
        if (pipe7 > 0) {
          pipe7 -= pipeAdder;
          if (pipe7 < 0) pipe7 = 0;
        } else {
          if (pipe6 > 0) {
            pipe6 -= pipeAdder;
            if (pipe6 < 0) pipe6 = 0;
          } else {
            if (pipe0 > 0) {
              pipe0 -= pipeAdder;
              if (pipe0 < 0) pipe0 = 0;
            }
          }
        }
        if (tankWaterFlow != 0) {
          tankWaterFlow = 0;
        } else {
          if (pipe5 > 0) {
            pipe5 -= pipeAdder;
            if (pipe5 < 0) pipe5 = 0;
          } else {
            if (pipe4 > 0) {
              pipe4 -= pipeAdder;
              if (pipe4 < 0) pipe4 = 0;
            } else {
              if (pipe3 > 0) {
                pipe3 -= pipeAdder;
                if (pipe3 < 0) pipe3 = 0;
              } else {
                if (pipe2 > 0) {
                  pipe2 -= pipeAdder;
                  if (pipe2 < 0) pipe2 = 0;
                } else {
                  if (pipe1 > 0) {
                    pipe1 -= pipeAdder;
                    if (pipe1 < 0) {
                      pipe1 = 0;
                    }
                  }
                }
              }
            }
          }
        }
      }
      if (dataStates.sunBrightness >= dataStates.minSunBrightness ||
          dataStates.batteryPercentage >=
              dataStates.batteryPercentageThreshold) {
        if (dataStates.roSwitch && dataStates.systemSwitch) {
          if ((dataStates.waterVolume / dataStates.maxWaterVolume) >= 0.2 &&
              dataStates.potableWaterVolume <
                  dataStates.maxPotableWaterVolume) {
            dataStates.batteryPercentage -= dataStates.roBatteryDrainRate / 100;
            if (potableTankWaterFlow > 0) {
              if (dataStates.potableWaterVolume <
                  dataStates.maxPotableWaterVolume) {
                dataStates.potableWaterVolume +=
                    (dataStates.waterFlowRate / 1000);
                dataStates.waterVolume -= (dataStates.waterFlowRate / 1000);
              }
            }

            if (pipe8 < 86.5) {
              pipe8 += pipeAdder;
              if (pipe8 > 86.5) pipe8 = 86.5;
            } else {
              if (pipe9 < 15) {
                pipe9 += pipeAdder;
                if (pipe9 > 15) pipe9 = 15;
              } else {
                if (pipe10 < 113) {
                  pipe10 += pipeAdder;
                  if (pipe10 > 113) pipe10 = 113;
                } else {
                  if (pipe11 < 57) {
                    pipe11 += pipeAdder;
                    if (pipe11 > 57) pipe11 = 57;
                  } else {
                    if (pipe12 < 6) {
                      pipe12 += pipeAdder;
                      if (pipe12 > 6) pipe12 = 12;
                    } else {
                      if (potableTankWaterFlow < 110) {
                        potableTankWaterFlow += pipeAdder;
                        if (potableTankWaterFlow > 110)
                          potableTankWaterFlow = 110;
                      }
                    }
                  }
                }
              }
            }
          } else {
            if (potableTankWaterFlow != 0) {
              potableTankWaterFlow = 0;
            } else {
              if (pipe12 > 0) {
                pipe12 -= pipeAdder;
                if (pipe12 < 0) pipe12 = 0;
              } else {
                if (pipe11 > 0) {
                  pipe11 -= pipeAdder;
                  if (pipe11 < 0) pipe11 = 0;
                } else {
                  if (pipe10 > 0) {
                    pipe10 -= pipeAdder;
                    if (pipe10 < 0) pipe10 = 0;
                  } else {
                    if (pipe9 > 0) {
                      pipe9 -= pipeAdder;
                      if (pipe9 < 0) pipe9 = 0;
                    } else {
                      if (pipe8 > 0) {
                        pipe8 -= pipeAdder;
                        if (pipe8 < 0) pipe8 = 0;
                      }
                    }
                  }
                }
              }
            }
          }
        } else {
          if (potableTankWaterFlow != 0) {
            potableTankWaterFlow = 0;
          } else {
            if (pipe12 > 0) {
              pipe12 -= pipeAdder;
              if (pipe12 < 0) pipe12 = 0;
            } else {
              if (pipe11 > 0) {
                pipe11 -= pipeAdder;
                if (pipe11 < 0) pipe11 = 0;
              } else {
                if (pipe10 > 0) {
                  pipe10 -= pipeAdder;
                  if (pipe10 < 0) pipe10 = 0;
                } else {
                  if (pipe9 > 0) {
                    pipe9 -= pipeAdder;
                    if (pipe9 < 0) pipe9 = 0;
                  } else {
                    if (pipe8 > 0) {
                      pipe8 -= pipeAdder;
                      if (pipe8 < 0) pipe8 = 0;
                    }
                  }
                }
              }
            }
          }
        }
        if (dataStates.pumpSwitch && dataStates.systemSwitch) {
          if (tankWaterFlow > 0) {
            if (dataStates.waterVolume < dataStates.waterVolumeThreshold) {
              dataStates.waterVolume += (dataStates.waterFlowRate / 1000);
              dataStates.batteryPercentage -=
                  dataStates.pumpBatteryDrainRate / 100;
            } else {
              if (dataStates.soilMoisture < dataStates.soilMoistureThreshold) {
                dataStates.toWaterTank = 1;
              } else {
                dataStates.toWaterTank = 2;
              }
            }
          }

          if (dataStates.soilMoisture < dataStates.soilMoistureThreshold)
            dataStates.waterTankSwitch = true;

          if (dataStates.soilMoisture >= 100) {
            dataStates.waterTankSwitch = false;
          }

          if (dataStates.waterVolume < dataStates.waterVolumeThreshold &&
              dataStates.waterTankSwitch == false) {
            dataStates.toWaterTank = 0;
          } else {
            if (dataStates.soilMoisture < dataStates.soilMoistureThreshold) {
              dataStates.toWaterTank = 1;
            }
          }
          if (dataStates.toWaterTank == 0) {
            gearAngle++;

            sprinkle = -1;
            if (pipe7 > 0) {
              pipe7 -= pipeAdder;
              if (pipe7 < 0) pipe7 = 0;
            } else {
              if (pipe6 > 0) {
                pipe6 -= pipeAdder;
                if (pipe6 < 0) pipe6 = 0;
              } else {}
            }
            if (pipe0 < 122) {
              pipe0 += pipeAdder;
              if (pipe0 > 122) pipe0 = 122;
            } else {
              if (pipe1 < 167) {
                pipe1 += pipeAdder;
                if (pipe1 > 167) pipe1 = 167;
              } else {
                if (pipe2 < 154) {
                  pipe2 += pipeAdder;
                  if (pipe2 > 154) pipe2 = 154;
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
                          if (tankWaterFlow > 110) tankWaterFlow = 110;
                        }
                      }
                    }
                  }
                }
              }
            }
          } else if (dataStates.toWaterTank == 1) {
            gearAngle++;
            if (tankWaterFlow != 0) {
              tankWaterFlow = 0;
            } else {
              if (pipe5 > 0) {
                pipe5 -= pipeAdder;
                if (pipe5 < 0) pipe5 = 0;
              } else {
                if (pipe4 > 0) {
                  pipe4 -= pipeAdder;
                  if (pipe4 < 0) pipe4 = 0;
                } else {
                  if (pipe3 > 0) {
                    pipe3 -= pipeAdder;
                    if (pipe3 < 0) pipe3 = 0;
                  } else {
                    if (pipe2 > 0) {
                      pipe2 -= pipeAdder;
                      if (pipe2 < 0) pipe2 = 0;
                    } else {
                      if (pipe1 > 0) {
                        pipe1 -= pipeAdder;
                        if (pipe1 < 0) {
                          pipe1 = 0;
                        }
                      }
                    }
                  }
                }
              }
            }
            if (pipe0 < 122) {
              pipe0 += pipeAdder;
              if (pipe0 > 122) pipe0 = 122;
            } else {
              if (pipe6 < 932) {
                pipe6 += pipeAdder;
                if (pipe6 > 932) pipe6 = 932;
              } else {
                if (pipe7 < 10) {
                  pipe7 += pipeAdder;
                  if (pipe7 > 10) pipe7 = 10;
                } else {
                  sprinkle += 0.1;
                  if (sprinkle > 11) sprinkle = 0;
                  dataStates.soilMoisture +=
                      dataStates.soilMoisteningRate / 100;
                  if (dataStates.soilMoisture > 100) {
                    dataStates.soilMoisture = 100;
                    dataStates.waterTankSwitch = false;
                    sprinkle = -1;
                    if (dataStates.waterVolume <
                        dataStates.waterVolumeThreshold) {
                      dataStates.toWaterTank = 0;
                    } else {
                      dataStates.toWaterTank = 2;
                    }
                  }
                }
              }
            }
          } else {
            if (pipe7 > 0) {
              pipe7 -= pipeAdder;
              if (pipe7 < 0) pipe7 = 0;
            } else {
              if (pipe6 > 0) {
                pipe6 -= pipeAdder;
                if (pipe6 < 0) pipe6 = 0;
              } else {
                if (pipe0 > 0) {
                  pipe0 -= pipeAdder;
                  if (pipe0 < 0) pipe0 = 0;
                }
              }
            }
            if (tankWaterFlow != 0) {
              tankWaterFlow = 0;
            } else {
              if (pipe5 > 0) {
                pipe5 -= pipeAdder;
                if (pipe5 < 0) pipe5 = 0;
              } else {
                if (pipe4 > 0) {
                  pipe4 -= pipeAdder;
                  if (pipe4 < 0) pipe4 = 0;
                } else {
                  if (pipe3 > 0) {
                    pipe3 -= pipeAdder;
                    if (pipe3 < 0) pipe3 = 0;
                  } else {
                    if (pipe2 > 0) {
                      pipe2 -= pipeAdder;
                      if (pipe2 < 0) pipe2 = 0;
                    } else {
                      if (pipe1 > 0) {
                        pipe1 -= pipeAdder;
                        if (pipe1 < 0) {
                          pipe1 = 0;
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        } else {
          sprinkle = -1;
          if (pipe7 > 0) {
            pipe7 -= pipeAdder;
            if (pipe7 < 0) pipe7 = 0;
          } else {
            if (pipe6 > 0) {
              pipe6 -= pipeAdder;
              if (pipe6 < 0) pipe6 = 0;
            } else {
              if (pipe0 > 0) {
                pipe0 -= pipeAdder;
                if (pipe0 < 0) pipe0 = 0;
              }
            }
          }
          if (tankWaterFlow != 0) {
            tankWaterFlow = 0;
          } else {
            if (pipe5 > 0) {
              pipe5 -= pipeAdder;
              if (pipe5 < 0) pipe5 = 0;
            } else {
              if (pipe4 > 0) {
                pipe4 -= pipeAdder;
                if (pipe4 < 0) pipe4 = 0;
              } else {
                if (pipe3 > 0) {
                  pipe3 -= pipeAdder;
                  if (pipe3 < 0) pipe3 = 0;
                } else {
                  if (pipe2 > 0) {
                    pipe2 -= pipeAdder;
                    if (pipe2 < 0) pipe2 = 0;
                  } else {
                    if (pipe1 > 0) {
                      pipe1 -= pipeAdder;
                      if (pipe1 < 0) {
                        pipe1 = 0;
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
      dataStates.soilMoistureController.text =
          dataStates.soilMoisture.toStringAsFixed(2);
      dataStates.waterVolumeController.text =
          dataStates.waterVolume.toStringAsFixed(2);
      dataStates.batteryPercentageController.text =
          dataStates.batteryPercentage.toStringAsFixed(2);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    var _blankFocus = FocusNode();
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(_blankFocus);
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
                      child: EnvironmentVariables(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: MainControlUnit(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: ReverseOsmosisUnit(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: SoilMoistureSensor(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: SolarPanel(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: WaterPump(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: WaterTank(),
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
                        child: Column(
                          children: [
                            InkWell(
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
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: InkWell(
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  restart();
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
                                    child: Icon(Icons.restart_alt_outlined),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                                color: Color(0XFFC86000).withOpacity(
                                    dataStates.soilMoisture / 100.0),
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
                                  color: Colors.yellow.withOpacity(
                                      dataStates.sunBrightness / 100.0),
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
                                duration: Duration(milliseconds: 1),
                                curve: Curves.linear,
                                width: pipeWidth,
                                height: pipe0,
                                color: Color(0XFF375E7D),
                              ),
                            ),
                            Positioned(
                              bottom: 216,
                              left: 91.5,
                              child: AnimatedContainer(
                                decoration: BoxDecoration(
                                  color: Color(0XFF375E7D),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(2),
                                  ),
                                ),
                                duration: Duration(milliseconds: 1),
                                curve: Curves.linear,
                                width: pipeWidth,
                                height: pipe1,
                              ),
                            ),
                            Positioned(
                              bottom: 378.5,
                              left: 92,
                              child: AnimatedContainer(
                                decoration: BoxDecoration(
                                  color: Color(0XFF375E7D),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(2),
                                    bottomRight: Radius.circular(2),
                                  ),
                                ),
                                duration: Duration(milliseconds: 1),
                                curve: Curves.linear,
                                width: pipe2,
                                height: pipeWidth,
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
                                duration: Duration(milliseconds: 1),
                                curve: Curves.linear,
                                width: pipeWidth,
                                height: pipe3,
                              ),
                            ),
                            Positioned(
                              bottom: 508,
                              left: 242,
                              child: AnimatedContainer(
                                decoration: BoxDecoration(
                                  color: Color(0XFF375E7D),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(2),
                                    topRight: Radius.circular(2),
                                  ),
                                ),
                                duration: Duration(milliseconds: 1),
                                curve: Curves.linear,
                                width: pipe4,
                                height: pipeWidth,
                              ),
                            ),
                            Positioned(
                              bottom: 504,
                              left: 294,
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
                                  width: pipeWidth,
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
                                  duration: Duration(milliseconds: 1),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0XFF375E7D),
                                    ),
                                    width: pipeWidth,
                                    height: tankWaterFlow,
                                  ),
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
                                height: pipeWidth,
                              ),
                            ),
                            Positioned(
                              bottom: 130,
                              left: 1030,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 1),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0XFF375E7D),
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(2),
                                    ),
                                  ),
                                  width: pipeWidth,
                                  height: pipe7,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 380,
                              left: 250,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 1),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0XFF375E7D),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  width: 95,
                                  height: 110 *
                                      (dataStates.waterVolume /
                                          dataStates.maxWaterVolume),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 394,
                              left: 354.5,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 1),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0XFF375E7D),
                                  ),
                                  width: pipe8,
                                  height: pipeWidth,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 336,
                              left: 523,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 1),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0XFF58B5D2),
                                    borderRadius: BorderRadius.only(
                                      // bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(2),
                                    ),
                                  ),
                                  width: pipe9,
                                  height: pipeWidth,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 336,
                              left: 533,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 1),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0XFF58B5D2),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(2),
                                      bottomRight: Radius.circular(2),
                                    ),
                                  ),
                                  width: pipeWidth,
                                  height: pipe10,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 445,
                              left: 533,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 1),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0XFF58B5D2),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(2),
                                      topLeft: Radius.circular(2),
                                    ),
                                  ),
                                  width: pipe11,
                                  height: pipeWidth,
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
                                  duration: Duration(milliseconds: 1),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0XFF58B5D2),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(2),
                                        topRight: Radius.circular(2),
                                      ),
                                    ),
                                    width: pipeWidth,
                                    height: pipe12,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 428,
                              left: 585,
                              child: Transform.rotate(
                                alignment: FractionalOffset.bottomCenter,
                                angle: -math.pi,
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 1),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0XFF58B5D2),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(2),
                                        topRight: Radius.circular(2),
                                      ),
                                    ),
                                    width: pipeWidth,
                                    height: potableTankWaterFlow,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 332,
                              left: 645,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 1),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0XFF58B5D2),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(2),
                                      topLeft: Radius.circular(2),
                                    ),
                                  ),
                                  width: pipe13,
                                  height: pipeWidth,
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
                                  duration: Duration(milliseconds: 1),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0XFF58B5D2),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(2),
                                      ),
                                    ),
                                    width: pipeWidth,
                                    height: pipe14,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 318,
                              left: 541,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 1),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0XFF58B5D2),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      topLeft: (dataStates.potableWaterVolume /
                                                  dataStates
                                                      .maxPotableWaterVolume >=
                                              0.97)
                                          ? Radius.circular(10)
                                          : Radius.circular(0),
                                      topRight: (dataStates.potableWaterVolume /
                                                  dataStates
                                                      .maxPotableWaterVolume >=
                                              0.97)
                                          ? Radius.circular(10)
                                          : Radius.circular(0),
                                    ),
                                  ),
                                  width: 95,
                                  height: 110 *
                                      (dataStates.potableWaterVolume /
                                          dataStates.maxPotableWaterVolume),
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
                                color: Colors.black.withOpacity((0.4 -
                                            (dataStates.sunBrightness / 100.0) <
                                        0)
                                    ? 0
                                    : 0.4 - (dataStates.sunBrightness / 100.0)),
                              ),
                            ),
                            Positioned(
                              bottom: 330,
                              left: 656,
                              child: InkWell(
                                onTap: () {
                                  dataStates
                                      .setToHousehold(!dataStates.toHousehold);
                                },
                                child: Opacity(
                                  opacity: dataStates.toHousehold ? 0.0 : 1.0,
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: grayButton,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 122,
                              left: 81,
                              child: Transform.rotate(
                                angle: dataStates.toWaterTank == 0
                                    ? -math.pi / 2
                                    : dataStates.toWaterTank == 1
                                        ? 0
                                        : -math.pi / 2,
                                child: InkWell(
                                  onTap: () {
                                    if (dataStates.toWaterTank == 0) {
                                      dataStates.setToWaterTank(1);
                                    } else {
                                      dataStates.setToWaterTank(0);
                                    }
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
                                        dataStates.setPumpSwitch(
                                            !dataStates.pumpSwitch);
                                      },
                                      child: Container(
                                        width: 15,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          color: dataStates.pumpSwitch &&
                                                  dataStates.systemSwitch
                                              ? Colors.red[700]
                                              : grayButton,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        dataStates.setSystemSwitch(
                                            !dataStates.systemSwitch);
                                      },
                                      child: Container(
                                        width: 15,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          color: dataStates.systemSwitch
                                              ? Colors.red[700]
                                              : grayButton,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        dataStates
                                            .setROSwitch(!dataStates.roSwitch);
                                      },
                                      child: Container(
                                        width: 15,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          color: dataStates.roSwitch &&
                                                  dataStates.systemSwitch
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
                            Positioned(
                              bottom: 150,
                              left: 800,
                              child: Opacity(
                                opacity:
                                    sprinkle >= 0 && sprinkle < 2 ? 1.0 : 0,
                                child: SvgPicture.asset(
                                    "assets/images/Group 48.svg"),
                              ),
                            ),
                            Positioned(
                              bottom: 150,
                              left: 800,
                              child: Opacity(
                                opacity:
                                    sprinkle >= 1 && sprinkle < 2 ? 1.0 : 0,
                                child: SvgPicture.asset(
                                    "assets/images/Group 50.svg"),
                              ),
                            ),
                            Positioned(
                              bottom: 150,
                              left: 800,
                              child: Opacity(
                                opacity:
                                    sprinkle >= 2 && sprinkle < 4 ? 1.0 : 0,
                                child: SvgPicture.asset(
                                    "assets/images/Group 53.svg"),
                              ),
                            ),
                            Positioned(
                              bottom: 150,
                              left: 800,
                              child: Opacity(
                                opacity:
                                    sprinkle >= 3 && sprinkle < 4 ? 1.0 : 0,
                                child: SvgPicture.asset(
                                    "assets/images/Group 54.svg"),
                              ),
                            ),
                            Positioned(
                              bottom: 150,
                              left: 800,
                              child: Opacity(
                                opacity:
                                    sprinkle >= 4 && sprinkle < 6 ? 1.0 : 0,
                                child: SvgPicture.asset(
                                    "assets/images/Group 58.svg"),
                              ),
                            ),
                            Positioned(
                              bottom: 150,
                              left: 800,
                              child: Opacity(
                                opacity:
                                    sprinkle >= 5 && sprinkle < 6 ? 1.0 : 0,
                                child: SvgPicture.asset(
                                    "assets/images/Group 60.svg"),
                              ),
                            ),
                            Positioned(
                              bottom: 150,
                              left: 750,
                              child: Opacity(
                                opacity:
                                    sprinkle >= 6 && sprinkle < 8 ? 1.0 : 0,
                                child: SvgPicture.asset(
                                    "assets/images/Group 61.svg"),
                              ),
                            ),
                            Positioned(
                              bottom: 150,
                              left: 800,
                              child: Opacity(
                                opacity:
                                    sprinkle >= 7 && sprinkle < 8 ? 1.0 : 0,
                                child: SvgPicture.asset(
                                    "assets/images/Group 62.svg"),
                              ),
                            ),
                            Positioned(
                              bottom: 150,
                              left: 800,
                              child: Opacity(
                                opacity:
                                    sprinkle >= 8 && sprinkle < 10 ? 1.0 : 0,
                                child: SvgPicture.asset(
                                    "assets/images/Group 74.svg"),
                              ),
                            ),
                            Positioned(
                              bottom: 150,
                              left: 800,
                              child: Opacity(
                                opacity:
                                    sprinkle >= 9 && sprinkle < 11 ? 1.0 : 0,
                                child: SvgPicture.asset(
                                    "assets/images/Group 75.svg"),
                              ),
                            ),
                            Positioned(
                              bottom: 150,
                              left: 750,
                              child: Opacity(
                                opacity:
                                    sprinkle >= 10 && sprinkle < 11 ? 1.0 : 0,
                                child: SvgPicture.asset(
                                    "assets/images/Group 76.svg"),
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
