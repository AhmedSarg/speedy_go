import 'color_manager.dart';
import 'values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: true,
    // main colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primary,
    primaryColorDark: ColorManager.primary,
    disabledColor: ColorManager.darkGrey,
    // ripple effect color
    splashColor: ColorManager.primary,
    scaffoldBackgroundColor: ColorManager.primary,
    // app bar theme
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.darkGrey,
      iconTheme: IconThemeData(color: ColorManager.white), //add this line here
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: ColorManager.white,
      surfaceTintColor: ColorManager.transparent
    ),
    // bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //     backgroundColor: ColorManager.primary,
    //     selectedIconTheme: IconThemeData(
    //       color: ColorManager.secondary,
    //       size: AppSize.s34,
    //     ),
    //     showUnselectedLabels: true,
    //
    //     unselectedIconTheme: IconThemeData(
    //       color: ColorManager.white,
    //       size: AppSize.s34,
    //     ),
    //     selectedItemColor: ColorManager.secondary,
    //     unselectedItemColor: ColorManager.white,
    //     showSelectedLabels: true,
    //     type: BottomNavigationBarType.fixed,
    //     selectedLabelStyle:
    //         AppTextStyles.btnNavBarSelectedLabelTextStyle(null),
    //     unselectedLabelStyle:
    //         AppTextStyles.btnNavBarUnselectedLabelTextStyle(null)),

    // button theme
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s100),
      ),
      disabledColor: ColorManager.lightGrey,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.secondary,
    ),

    // elevated button them
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        // textStyle: AppTextStyles.loginButtonTextStyle(null),
        foregroundColor: ColorManager.white,
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s100),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: ColorManager.transparent,
        foregroundColor: ColorManager.primary,
        shape: const StadiumBorder(),
      ),
    ),

    // input decoration theme (text form field)
    inputDecorationTheme: const InputDecorationTheme(
      // content padding
      contentPadding: EdgeInsets.all(AppPadding.p8),
      // hint style
      // labelStyle: AppTextStyles.textFieldLabelTextStyle(null),
      // errorStyle: AppTextStyles.textFieldErrorTextStyle(null),
      filled: true,
      fillColor: ColorManager.offwhite,
    ),
  );
}
