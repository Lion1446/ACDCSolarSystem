import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solarpumpingsystem/themes.dart';

class WaterPump extends StatelessWidget {
  const WaterPump({
    Key? key,
    required this.waterFlowRateController,
    required this.batteryDrainRateController,
    required this.pumpSwitch,
    required this.toWaterTank,
    required this.batteryDrainRate,
    required this.waterFlowRate,
  }) : super(key: key);

  final TextEditingController waterFlowRateController;
  final TextEditingController batteryDrainRateController;
  final bool pumpSwitch;
  final bool toWaterTank;
  final double waterFlowRate;
  final double batteryDrainRate;
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
            "Water Pump",
            style: fonts.component,
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    "Working Status",
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
                      pumpSwitch ? "enabled" : "disabled",
                      style: fonts.component.copyWith(
                        color: pumpSwitch
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
                    "Flow Rate (L/sec):",
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
                      controller: waterFlowRateController,
                      decoration: InputDecoration.collapsed(
                        hintText: '$waterFlowRate',
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
                    "Flow Direction:",
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
                      toWaterTank ? "water tank" : "sprinkler",
                      style: fonts.component.copyWith(
                        color: green.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.left,
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
                    "Battery Drain Rate (%/sec):",
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
                      controller: batteryDrainRateController,
                      decoration: InputDecoration.collapsed(
                        hintText: '$batteryDrainRate',
                        hintStyle: fonts.component
                            .copyWith(color: Colors.black.withOpacity(0.5)),
                      ),
                      style: fonts.component.copyWith(
                          color: batteryDrainRate >= 100 ? red : green),
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
