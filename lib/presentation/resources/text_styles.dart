import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle baseStatesMessageTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.primaryEnglishFont,
        color: ColorManager.primary,
        fontSize: FontSize.f16,
      );

  static TextStyle baseStatesElevatedBtnTextStyle(BuildContext? context) =>
      getBoldStyle(
        fontFamily: FontConstants.primaryEnglishFont,
        color: ColorManager.white,
        fontSize: FontSize.f14,
      );

  static TextStyle splashScreenTitleTextStyle(BuildContext? context) =>
      getRegularStyle(
        fontFamily: FontConstants.primaryEnglishFont,
        color: ColorManager.white,
        fontSize: FontSize.f60,
      );

  static TextStyle splashScreenSubTitleTextStyle(BuildContext? context) =>
      getLightStyle(
        fontFamily: FontConstants.primaryEnglishFont,
        color: ColorManager.white,
        fontSize: FontSize.f28,
      );

  ///Selection Screen

  static TextStyle selectionScreenTileTextStyle(BuildContext? context) =>
      getLightStyle(
        fontFamily: FontConstants.primaryEnglishFont,
        color: ColorManager.white,
        fontSize: FontSize.f40,
      );

  static TextStyle selectionScreenTitleTextStyle(BuildContext? context) =>
      getLightStyle(
        fontFamily: FontConstants.primaryEnglishFont,
        color: ColorManager.white,
        fontSize: FontSize.f40,
      );

}
