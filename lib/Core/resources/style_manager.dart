import 'package:flutter/material.dart';
import 'package:sahem/Core/resources/color_manager.dart';
import 'package:sahem/Core/resources/font_manger.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color? color) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontConstants.fontFamily,
    color: color ?? ColorManager.black,
    fontWeight: fontWeight,
  );
}

TextStyle getLightStyle({
  double? fontSize,
  Color? color,
}) {
  return _getTextStyle(fontSize ?? FontSize.s12, FontWeightManager.light,
      color ?? ColorManager.black);
}

TextStyle getRegularStyle({double? fontSize, Color? color}) {
  return _getTextStyle(
      fontSize ?? FontSize.s18, FontWeight.w400, color ?? ColorManager.black);
}

TextStyle getMediumStyle({double? fontSize, Color? color}) {
  return _getTextStyle(fontSize ?? FontSize.s12, FontWeightManager.medium,
      color ?? ColorManager.black);
}

TextStyle getSemiBoldStyle({double? fontSize, Color? color}) {
  return _getTextStyle(fontSize ?? FontSize.s12, FontWeightManager.semiBold,
      color ?? ColorManager.black);
}

TextStyle getBoldStyle({double? fontSize, Color? color}) {
  return _getTextStyle(
      fontSize ?? FontSize.s12, FontWeight.w700, color ?? ColorManager.black);
}
