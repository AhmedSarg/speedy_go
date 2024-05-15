import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';

class BusesTextField extends StatefulWidget {
  const BusesTextField(
      {super.key,
      this.controller,
      this.focusNode,
      this.nextFocus,
      this.label,
      required this.hint,
      this.isObscured = false,
      this.prefixIcon,
      this.textInputType = TextInputType.text,
      this.backgroundColor,
      this.hintTextStyle,
      this.labelTextStyle,
      this.cursorColor = ColorManager.white,
      this.readOnly = false,
      this.validation,
      this.onTap,
      this.suffixIcon,
      this.suffixIconFunc,
      this.initialValue,
      this.inputFormatters});

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final bool isObscured;
  final String? label;
  final String hint;
  final String? initialValue;
  final TextInputType textInputType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final void Function()? suffixIconFunc;
  final List<TextInputFormatter>? inputFormatters;
  final Color? backgroundColor;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final Color cursorColor;
  final bool readOnly;

  final String? Function(String?)? validation;
  final void Function()? onTap;

  @override
  State<BusesTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<BusesTextField> {
  late bool hidden = widget.isObscured;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      inputFormatters: widget.inputFormatters,
      controller: widget.controller,
      focusNode: widget.focusNode,
      readOnly: widget.readOnly,
      style:
          widget.hintTextStyle ?? AppTextStyles.busesItemTripTextStyle(context),
      obscureText: hidden,
      keyboardType: widget.textInputType,
      obscuringCharacter: '*',
      cursorColor: widget.cursorColor,
      onTap: widget.onTap,
      onEditingComplete: () {
        widget.focusNode?.unfocus();
        if (widget.nextFocus != null) {
          FocusScope.of(context).requestFocus(widget.nextFocus);
        }
      },
      textInputAction: widget.nextFocus == null
          ? TextInputAction.done
          : TextInputAction.next,
      validator: (value) {
        if (widget.validation == null) {
          setState(() {
            errorText = null;
          });
        } else {
          setState(() {
            errorText = widget.validation!(value);
          });
        }
        return errorText;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(AppPadding.p12),
        hintText: widget.hint,
        hintStyle: widget.hintTextStyle ??
            AppTextStyles.bookTripSearchScreenSubTitleItemTextStyle(context),
        border: InputBorder.none,
        errorStyle: const TextStyle(
          fontSize: AppSize.s0,
          color: ColorManager.transparent,
        ),
      ),
    );
  }
}
