import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solarpumpingsystem/themes.dart';

class EnvironmentVariables extends StatelessWidget {
  const EnvironmentVariables({
    Key? key,
    required this.sunBrightnessController,
    required this.soilMoistureController,
    required this.soilDryingRateController,
    required this.soilMoisteningRateController,
    required this.sunBrightness,
    required this.minSunBrightness,
    required this.soilMoisture,
    required this.soilMoistureThreshold,
    required this.soilDryingRate,
    required this.soilDryingRateThreshold,
    required this.soilMoisteningRate,
    required this.soilMoisteningRateThreshold,
  }) : super(key: key);
  final TextEditingController sunBrightnessController;
  final TextEditingController soilMoistureController;
  final TextEditingController soilDryingRateController;
  final TextEditingController soilMoisteningRateController;
  final double sunBrightness;
  final double minSunBrightness;
  final double soilMoisture;
  final double soilMoistureThreshold;
  final double soilDryingRate;
  final double soilDryingRateThreshold;
  final double soilMoisteningRate;
  final double soilMoisteningRateThreshold;

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
            "Environment Variables",
            style: fonts.component,
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    "Sun Brightness (%):",
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
                      controller: sunBrightnessController,
                      decoration: InputDecoration.collapsed(
                        hintText: '$sunBrightness',
                        hintStyle: fonts.component
                            .copyWith(color: Colors.black.withOpacity(0.5)),
                      ),
                      style: fonts.component.copyWith(
                          color:
                              sunBrightness >= minSunBrightness ? green : red),
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
                    "Soil Moisture (%):",
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
                      controller: soilMoistureController,
                      decoration: InputDecoration.collapsed(
                        hintText: '$soilMoisture',
                        hintStyle: fonts.component
                            .copyWith(color: Colors.black.withOpacity(0.5)),
                      ),
                      style: fonts.component.copyWith(
                          color: soilMoisture >= soilMoistureThreshold
                              ? green
                              : red),
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
                    "Soil Drying Rate (%/sec):",
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
                      controller: soilDryingRateController,
                      decoration: InputDecoration.collapsed(
                        hintText: '$soilDryingRate',
                        hintStyle: fonts.component
                            .copyWith(color: Colors.black.withOpacity(0.5)),
                      ),
                      style: fonts.component.copyWith(
                          color: soilDryingRate <= soilDryingRateThreshold
                              ? green
                              : red),
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
                    "Soil Moistening Rate (%/sec):",
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
                      controller: soilMoisteningRateController,
                      decoration: InputDecoration.collapsed(
                        hintText: '$soilMoisteningRate',
                        hintStyle: fonts.component
                            .copyWith(color: Colors.black.withOpacity(0.5)),
                      ),
                      style: fonts.component.copyWith(
                          color:
                              soilMoisteningRate >= soilMoisteningRateThreshold
                                  ? green
                                  : red),
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
