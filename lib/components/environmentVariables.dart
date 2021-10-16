import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:solarpumpingsystem/providers.dart';
import 'package:solarpumpingsystem/themes.dart';

class EnvironmentVariables extends StatelessWidget {
  const EnvironmentVariables({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dataStates = Provider.of<DataProviders>(context);
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
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'))
                      ],
                      controller: dataStates.sunBrightnessController,
                      decoration: InputDecoration.collapsed(
                        hintText: "",
                        hintStyle: fonts.component
                            .copyWith(color: Colors.black.withOpacity(0.5)),
                      ),
                      style: fonts.component.copyWith(
                        color: dataStates.sunBrightness >=
                                dataStates.minSunBrightness
                            ? green
                            : red,
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
                    child: TextFormField(
                      controller: dataStates.soilMoistureController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'))
                      ],
                      decoration: InputDecoration.collapsed(
                        hintText: '',
                        hintStyle: fonts.component
                            .copyWith(color: Colors.black.withOpacity(0.5)),
                      ),
                      style: fonts.component.copyWith(
                        color: dataStates.soilMoisture >=
                                dataStates.soilMoistureThreshold
                            ? green
                            : red,
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
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'))
                      ],
                      controller: dataStates.soilDryingRateController,
                      decoration: InputDecoration.collapsed(
                        hintText: '',
                        hintStyle: fonts.component
                            .copyWith(color: Colors.black.withOpacity(0.5)),
                      ),
                      style: fonts.component.copyWith(
                        color: dataStates.soilDryingRate <=
                                dataStates.soilDryingRateThreshold
                            ? green
                            : red,
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
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'))
                      ],
                      controller: dataStates.soilMoisteningRateController,
                      decoration: InputDecoration.collapsed(
                        hintText: '',
                        hintStyle: fonts.component
                            .copyWith(color: Colors.black.withOpacity(0.5)),
                      ),
                      style: fonts.component.copyWith(
                        color: dataStates.soilMoisteningRate >=
                                dataStates.soilMoisteningRateThreshold
                            ? green
                            : red,
                      ),
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
