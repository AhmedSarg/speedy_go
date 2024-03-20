import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';

class AppTextStyles {
  AppTextStyles._();
  static TextStyle SplashScreenTitleTextStyle(BuildContext? context) =>
      getRegularStyle(
        fontFamily: FontConstants.primaryEnglishFont,
        color: ColorManager.white,
        fontSize: FontSize.s60,
      );
  static TextStyle SplashScreenSubTitleTextStyle(BuildContext? context) =>
      getLightStyle(
        fontFamily: FontConstants.primaryEnglishFont,
        color: ColorManager.white,
        fontSize: FontSize.s28,
      );

  static TextStyle baseStatesMessageTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.primaryEnglishFont,
        color: ColorManager.primary,
        fontSize: FontSize.s16,
      );

  static TextStyle baseStatesElevatedBtnTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.primaryEnglishFont,
        color: ColorManager.white,
        fontSize: FontSize.s14,
      );
}
