import 'package:color_convert_null_safety/color_convert.dart';
import 'package:flutter/material.dart';

class ColorUtil {
  static Color stringToColor(String color, {Color? defaultColor}) {
    try {
      return Color.fromARGB(255, convert.keyword.rgb(color)[0],
          convert.keyword.rgb(color)[1], convert.keyword.rgb(color)[2]);
    } catch (e) {
      return defaultColor ?? Colors.black;
    }
  }
}
