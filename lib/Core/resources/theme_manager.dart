import 'package:flutter/material.dart';
import 'package:sahem/Core/resources/color_manager.dart';
import 'package:sahem/Core/resources/font_manger.dart';
import 'package:sahem/Core/resources/style_manager.dart';

ThemeData getAppTheme() {
  return ThemeData(
      fontFamily: FontConstants.fontFamily,
      scaffoldBackgroundColor: ColorManager.black,
      textTheme: TextTheme(
        displayLarge:
            getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s20),
        headlineLarge: getSemiBoldStyle(
            //headline1
            color: ColorManager.black,
            fontSize: FontSize.s16),
        headlineMedium: getRegularStyle(
            //headline1
            color: ColorManager.black,
            fontSize: FontSize.s14),
        titleMedium: getMediumStyle(
            //SubTitle1
            color: ColorManager.black,
            fontSize: FontSize.s16),
        bodyLarge: getRegularStyle(color: ColorManager.black), // Caption
        bodySmall: getRegularStyle(color: ColorManager.black), //bodyText
      ));
}
