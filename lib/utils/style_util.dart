import 'package:flutter/material.dart';

class StyleUtils {
  static TextStyle? mTextStyle(double size, int color) {
    return TextStyle(fontSize: size, color: Color(color));
  }

  static TextStyle? mTextStyle2(double size, Color color) {
    return TextStyle(fontSize: size, color: color);
  }

  static ButtonStyle? mButtonStyle(
      double radius, double borderWidth, Color borderColor, Color bgColor) {
    return ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius))),
        side: MaterialStateProperty.all(
            BorderSide(color: borderColor, width: borderWidth)),
        backgroundColor: MaterialStateProperty.all(bgColor));
  }
}
