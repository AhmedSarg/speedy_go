import 'package:flutter/material.dart';
import 'package:speedy_go/presentation/resources/langauge_manager.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';

class AppTextStyles {
  AppTextStyles._();

  ///Base

  static TextStyle baseStatesMessageTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.secondary,
        fontSize: FontSize.f16,
      );

  static TextStyle baseStatesElevatedBtnTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f14,
      );

  ///Common

  static TextStyle appButtonTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f18,
      );

  static TextStyle textFieldErrorTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.error.withOpacity(.7),
        fontSize: FontSize.f12,
      );

  static TextStyle optionsMenuOptionTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f14,
      );

  ///Splash Screen

  static TextStyle splashScreenTitleTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f60,
      );

  static TextStyle splashScreenSubTitleTextStyle(BuildContext context) =>
      getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f28,
      );

  ///OnBoarding Screen

  static TextStyle onBoardingScreenTitleTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f24,
      );

  static TextStyle onBoardingScreenButtonTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f14,
      );

  ///Selection Old Screen

  static TextStyle selectionScreenTileTextStyle(BuildContext context) =>
      getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f40,
      );

  static TextStyle selectionScreenTitleTextStyle(BuildContext context) =>
      getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f40,
      );

  ///Selection Screen

  static TextStyle selectionScreenButtonTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f18,
      );

  ///Login Screen

  static TextStyle loginScreenTitleTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f20,
      );

  static TextStyle loginScreenCountryCodeValueTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f14,
      );

  static TextStyle loginScreenDontHaveAccountTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f12,
      );

  static TextStyle loginScreenCreateAccountTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.secondary,
        fontSize: FontSize.f12,
      );

  static TextStyle loginScreenTextFieldHintTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white.withOpacity(.5),
        fontSize: FontSize.f14,
      );

  static TextStyle loginScreenTextFieldValueTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f14,
      );

  static TextStyle loginScreenSelectorTextStyle(BuildContext context, Color color) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: color,
        fontSize: FontSize.f12,
      );

  ///Register Screen

  static TextStyle registerScreenTitleTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f20,
      );

  static TextStyle registerScreenAlreadyHaveAccountTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f12,
      );

  static TextStyle registerScreenLoginTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.secondary,
        fontSize: FontSize.f12,
      );

  static TextStyle registerScreenTextFieldHintTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white.withOpacity(.5),
        fontSize: FontSize.f14,
      );

  static TextStyle registerScreenTextFieldValueTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f14,
      );

  static TextStyle registerScreenSelectorTextStyle(BuildContext context, Color color) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: color,
        fontSize: FontSize.f12,
      );

  static TextStyle registerScreenVehicleSelectionBodyTextStyle(BuildContext context, Color color, double size) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: color,
        fontSize: size,
      );

  static TextStyle registerScreenVerifyDescriptionTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white.withOpacity(.4),
        fontSize: FontSize.f12,
      );

}
