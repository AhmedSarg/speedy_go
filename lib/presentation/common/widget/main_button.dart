import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../resources/text_styles.dart';
import '../../resources/values_manager.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.outlined = false,
    this.textStyle,
    this.color,
    this.child,
    this.splash,
    this.bgColor,
    this.borderRadius,
  });

  final String? text;
  final Function() onPressed;
  final bool outlined;
  final TextStyle? textStyle;
  final Color? color;
  final Color? bgColor;
  final Widget? child;
  final Color? splash;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSize.s40,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          foregroundColor: outlined
              ? (color ?? ColorManager.secondary)
              : (color ?? ColorManager.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s12),
            side: outlined
                ? BorderSide(
                    color: color ?? ColorManager.secondary,
                    width: AppSize.s1,
                  )
                : BorderSide.none,
          ),
          backgroundColor:
              outlined ? ColorManager.transparent : ColorManager.secondary,
        ),
        child: child ??
            Text(
              text ?? '',
              style: textStyle ?? AppTextStyles.appButtonTextStyle(context),
            ),
      ),
    );
  }
}

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.outlined = false,
    this.textStyle,
    this.color,
    this.child,
    this.splash,
    this.bgcolor,
    this.borderRadius,
  });

  final String? text;
  final Function() onPressed;
  final bool outlined;
  final TextStyle? textStyle;
  final Color? color;
  final Color? bgcolor;
  final Widget? child;
  final Color? splash;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSize.s40,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: outlined
              ? (color ?? ColorManager.secondary)
              : (color ?? ColorManager.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s12),
            side: outlined
                ? BorderSide(
                    color: color ?? ColorManager.secondary,
                    width: AppSize.s1,
                  )
                : BorderSide.none,
          ),
          backgroundColor: bgcolor ?? ColorManager.lightBlue,
        ),
        child: child ??
            Text(
              text ?? '',
              style: textStyle ?? AppTextStyles.appButtonTextStyle(context),
            ),
      ),
    );
  }
}

class SecondButton extends StatelessWidget {
  const SecondButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.outlined = false,
    this.textStyle,
    this.child,
    this.bgcolor,
    this.borderRadius,
  });

  final String? text;
  final Function() onPressed;
  final bool outlined;
  final TextStyle? textStyle;
  final Color? bgcolor;
  final Widget? child;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSize.s40,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s12),
            side: outlined
                ? const BorderSide(
                    width: AppSize.s1,
                  )
                : BorderSide.none,
          ),
          backgroundColor: bgcolor ?? ColorManager.error,
        ),
        child: child ??
            Text(
              text ?? '',
              style: textStyle ?? AppTextStyles.appButtonTextStyle(context),
            ),
      ),
    );
  }
}
