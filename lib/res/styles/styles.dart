import 'package:flutter/material.dart';
import 'package:unlimit_demo/res/styles/font_sizes.dart';

class AppColors {
  AppColors._();

  static const Color primaryColor = Color(0xffb32929);

  //Primary text color according to design
  static const Color primaryTextColor = Color(0xff121212);

  static const Color borderColor = Color(0xffEBEBEB);

  static const Color appBackgroundColor = Color(0xffEBEBEB);
}

TextStyle getTextStyle({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  double? letterSpacing,
  TextDecoration? textDecoration,
  double? height,
  String? fontFamily,
}) {
  return TextStyle(
    fontFamily: fontFamily,
    color: color ?? AppColors.primaryTextColor,
    fontSize: fontSize ?? FontSizes.normalTextSize,
    fontWeight: fontWeight,
    decoration: textDecoration,
    letterSpacing: letterSpacing,
    height: height,
  );
}
