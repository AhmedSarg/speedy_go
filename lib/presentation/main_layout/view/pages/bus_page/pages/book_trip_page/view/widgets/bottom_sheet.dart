import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';
import 'package:speedy_go/presentation/resources/font_manager.dart';
import 'package:speedy_go/presentation/resources/text_styles.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

class BottomSheet_items extends StatelessWidget {
  const BottomSheet_items({super.key, required this.tittle});
final String tittle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16,vertical: AppPadding.p12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(onPressed: () {
                Navigator.pop(context);
              }, icon: const Icon(Icons.close,color: ColorManager.grey,)),
              const SizedBox(width: AppSize.s5,),
              Text(tittle,style: AppTextStyles.profileGeneralTextStyle(context, FontSize.f20,ColorManager.lightBlue),),
            ],
          ),
          Container(
            child: BookingTextField(hint: '',),
          ),
          Container(
            child: BookingTextField(hint: '',),
          ),
          Container(
            child: BookingTextField(hint: '',),
          ),
        ],
      ),
    );
  }
}









class BookingTextField extends StatefulWidget {
  BookingTextField({
    super.key,
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
    this.surffixIcon, this.surffixIconFunc,  this.initialValue,this.inputFormatters
  });

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
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final Color cursorColor;
  final bool readOnly;

  final String? Function(String?)? validation;
  final void Function()? onTap;
  @override
  State<BookingTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<BookingTextField> {
  late bool hidden = widget.isObscured;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s10),
        color: ColorManager.darkBlack
      ),
      child: TextFormField(

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
suffixIcon: const Icon(Icons.keyboard_arrow_down,size: AppSize.s24,color: ColorManager.offwhite,),
          hintStyle: widget.hintTextStyle ??
              AppTextStyles.profileGeneralTextStyle(context,FontSize.f16,ColorManager.offwhite),
          border: InputBorder.none,

          errorStyle: const TextStyle(
            fontSize: AppSize.s0,
            color: ColorManager.transparent,
          ),
        ),
      ),
    );
  }
}
