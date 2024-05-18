import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    useMaterial3: true,
    // main colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primary,
    primaryColorDark: ColorManager.primary,
    disabledColor: ColorManager.darkGrey,
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
        backgroundColor: ColorManager.primary,
        surfaceTintColor: ColorManager.transparent),

    tabBarTheme: TabBarTheme(
      // overlayColor: WidgetStateProperty.all(ColorManager.blue.withOpacity(.05)),
    ),
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
        foregroundColor: ColorManager.white,
        backgroundColor: ColorManager.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: ColorManager.transparent,
        foregroundColor: ColorManager.secondary,
      ),
    ),

    // input decoration theme (text form field)
    inputDecorationTheme: const InputDecorationTheme(
      // content padding
      contentPadding: EdgeInsets.all(AppPadding.p8),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      selectionHandleColor: ColorManager.secondary,
      selectionColor: ColorManager.secondary,
    ),
  );
}
