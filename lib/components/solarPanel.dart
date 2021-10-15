import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solarpumpingsystem/themes.dart';

class SolarPanel extends StatelessWidget {
  const SolarPanel({
    Key? key,
    required this.solarPanelVoltageController,
    required this.batteryChargeRateController,
    required this.solarPanelMaxVoltageController,
    required this.minSunBrightnessController,
    required this.solarPanelVoltage,
    required this.solarPanelMaxVoltage,
    required this.minSunBrightness,
    required this.batteryChargeRate,
  }) : super(key: key);

  final TextEditingController solarPanelVoltageController;
  final TextEditingController batteryChargeRateController;
  final TextEditingController solarPanelMaxVoltageController;
  final TextEditingController minSunBrightnessController;
  final double solarPanelVoltage;
  final double solarPanelMaxVoltage;
  final double minSunBrightness;
  final double batteryChargeRate;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Solar Panel",
            style: fonts.component,
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    "Voltage (volts)",
                    style: fonts.component.copyWith(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      solarPanelVoltage.toString(),
                      style: fonts.component.copyWith(
                        color: solarPanelVoltage != 0
                            ? green.withOpacity(0.7)
                            : red.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    "Max Voltage (volts):",
                    style: fonts.component.copyWith(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'))
                      ],
                      controller: solarPanelMaxVoltageController,
                      decoration: InputDecoration.collapsed(
                        hintText: '$solarPanelMaxVoltage',
                        hintStyle: fonts.component
                            .copyWith(color: Colors.black.withOpacity(0.5)),
                      ),
                      style: fonts.component.copyWith(color: green),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    "Min. Sun Brightness (%):",
                    style: fonts.component.copyWith(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'))
                      ],
                      controller: minSunBrightnessController,
                      decoration: InputDecoration.collapsed(
                        hintText: '$minSunBrightness',
                        hintStyle: fonts.component
                            .copyWith(color: Colors.black.withOpacity(0.5)),
                      ),
                      style: fonts.component.copyWith(
                          color: minSunBrightness == 100 ? red : green),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    "Battery Charge Rate (%/sec):",
                    style: fonts.component.copyWith(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'))
                      ],
                      controller: batteryChargeRateController,
                      decoration: InputDecoration.collapsed(
                        hintText: '$batteryChargeRate',
                        hintStyle: fonts.component
                            .copyWith(color: Colors.black.withOpacity(0.5)),
                      ),
                      style: fonts.component.copyWith(
                          color: batteryChargeRate >= 100 ? red : green),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
