import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../resources/color_manager.dart';
import '../../resources/text_styles.dart';
import '../../resources/values_manager.dart';

class SearchTextField extends StatefulWidget {
  SearchTextField(
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
      this.surffixIcon,
      this.surffixIconFunc,
      this.initialValue,
      this.inputFormatters, this.onChanged, this.inputTextStyle});

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final bool isObscured;
  final String? label;
  final String hint;
  final String? initialValue;
  final TextInputType textInputType;
  final IconData? prefixIcon;
  final IconData? surffixIcon;
  final void Function()? surffixIconFunc;
  List<TextInputFormatter>? inputFormatters;
  final Color? backgroundColor;
  final TextStyle? inputTextStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final Color cursorColor;
  final bool readOnly;
  final void Function(String)? onChanged;
  final String? Function(String?)? validation;
  final void Function()? onTap;
  @override
  State<SearchTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<SearchTextField> {
  late bool hidden = widget.isObscured;
  String? errorText;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(AppSize.s18),
          color: ColorManager.charcoalGrey.withOpacity(.85)),
      child: TextFormField(


        onChanged: widget.onChanged,
        initialValue: widget.initialValue,
        inputFormatters: widget.inputFormatters,
        controller: widget.controller,
        focusNode: widget.focusNode,
        readOnly: widget.readOnly,
        style: widget.inputTextStyle ??widget.hintTextStyle??
            AppTextStyles.busesItemTripTextStyle(context),
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
              AppTextStyles.busesItemSearchHintTextStyle(context),
          border: InputBorder.none,
          prefixIcon: Icon(widget.prefixIcon,size: AppSize.s20,color: ColorManager.offwhite,),
          errorStyle: const TextStyle(
            fontSize: AppSize.s0,
            color: ColorManager.transparent,
          ),
        ),
      ),
    );
  }
}
