import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solarpumpingsystem/providers.dart';
import 'package:solarpumpingsystem/themes.dart';

class MainControlUnit extends StatelessWidget {
  const MainControlUnit({Key? key}) : super(key: key);

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
            "Main Control Unit",
            style: fonts.component,
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    "Working Status:",
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
                      dataStates.systemSwitch ? "enabled" : "disabled",
                      style: fonts.component.copyWith(
                        color: dataStates.systemSwitch
                            ? green.withOpacity(0.7)
                            : red.withOpacity(0.7),
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
