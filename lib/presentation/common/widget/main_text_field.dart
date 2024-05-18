import 'package:flutter/material.dart';
import 'package:speedy_go/presentation/resources/text_styles.dart';

import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.focusNode,
    this.nextFocus,
    required this.controller,
    this.width = AppSize.s300,
    this.height = AppSize.s50,
    required this.validator,
    this.obscureText = false,
    required this.keyboardType,
    this.readOnly = false,
    this.onTap,
  });

  final FocusNode focusNode;
  final FocusNode? nextFocus;
  final TextEditingController controller;
  final double width, height;
  final String? Function(String?) validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final void Function()? onTap;
  final bool readOnly;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? errorText;
  bool focused = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: AppMargin.m8, horizontal: AppMargin.m12),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        cursorWidth: AppSize.s1,
        cursorColor: ColorManager.white,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        style: AppTextStyles.profileItemUpdateSubFieldTextStyle(
            context, ColorManager.offwhite),
        onTap: widget.onTap,
        readOnly: widget.readOnly,
        validator: widget.validator,
        textInputAction: widget.nextFocus == null
            ? TextInputAction.done
            : TextInputAction.next,
        onEditingComplete: () {
          widget.focusNode.unfocus();
          if (widget.nextFocus != null) {
            widget.nextFocus!.requestFocus();
          }
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorManager.lightBlack,
              width: AppSize.s1,
            ),
            borderRadius: BorderRadius.circular(AppSize.s12),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorManager.lightBlack,
              width: AppSize.s1,
            ),
            borderRadius: BorderRadius.circular(AppSize.s12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorManager.lightBlack,
              width: AppSize.s1,
            ),
            borderRadius: BorderRadius.circular(AppSize.s12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorManager.error,
              width: AppSize.s1,
            ),
            borderRadius: BorderRadius.circular(AppSize.s12),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorManager.error,
              width: AppSize.s1,
            ),
            borderRadius: BorderRadius.circular(AppSize.s12),
          ),
        ),
      ),
    );
  }
}
