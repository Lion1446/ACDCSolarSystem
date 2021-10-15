import 'package:flutter/material.dart';

Typography fonts = Typography();
Color grayButton = Color(0XFFC4C4C4C4);
Color green = Color(0XFF25AC0F);
Color red = Color(0XFFFF0D0D);

class Typography {
  TextStyle header = TextStyle(
    fontFamily: "Comfortaa",
    fontWeight: FontWeight.bold,
    fontSize: 24,
    height: 43 / 36,
  );

  TextStyle component = TextStyle(
    fontFamily: "Comfortaa",
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 13 / 12,
  );
}
