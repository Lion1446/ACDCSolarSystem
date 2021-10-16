import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:solarpumpingsystem/themes.dart';

import '../providers.dart';

class SoilMoistureSensor extends StatelessWidget {
  const SoilMoistureSensor({
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
            "Soil Moisture Sensor",
            style: fonts.component,
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    "Moisture Percentage (%):",
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
                      dataStates.soilMoisture.toString(),
                      style: fonts.component.copyWith(
                        color: dataStates.soilMoisture >=
                                dataStates.soilMoistureThreshold
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
                    "Moisture Threshold (%):",
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
                      controller: dataStates.soilMoistureThresholdController,
                      decoration: InputDecoration.collapsed(
                        hintText: '',
                        hintStyle: fonts.component
                            .copyWith(color: Colors.black.withOpacity(0.5)),
                      ),
                      style: fonts.component.copyWith(
                        color: dataStates.soilMoistureThreshold >= 100
                            ? red
                            : green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
