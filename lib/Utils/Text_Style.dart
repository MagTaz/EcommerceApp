import 'package:ecommerce_app/Utils/Fonts.dart';
import 'package:flutter/material.dart';

class Text_Style {
  static textStyleNormal(Color color, double size) {
    return TextStyle(
        fontFamily: Fonts.PrimaryFont, fontSize: size, color: color);
  }

  static textStyleBold(Color color, double size) {
    return TextStyle(
        fontFamily: Fonts.PrimaryBoldFont, fontSize: size, color: color);
  }
}
