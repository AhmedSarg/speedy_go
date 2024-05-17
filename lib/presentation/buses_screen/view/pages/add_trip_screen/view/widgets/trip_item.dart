import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speedy_go/presentation/resources/text_styles.dart';

import '../../../../../../resources/color_manager.dart';
import '../../../../../../resources/strings_manager.dart';
import '../../../../../../resources/values_manager.dart';
import '../../../../../view/widgets/text_field.dart';

class TripItem extends StatelessWidget {
  TripItem({
    super.key,
    required this.title,
    required this.hintText,
    required this.read,
    required this.textInputType,
    this.onTap,
    this.icon,
    this.validation,
    this.inputFormatNumber,
    this.iconFunction,
    this.controller,
  });

  final String title;
  final String hintText;
  final bool read;
  final TextInputType textInputType;
  final void Function()? onTap;
  final Widget? iconFunction;
  final IconData? icon;
  final int? inputFormatNumber;
  final TextEditingController? controller;
  final String? Function(String?)? validation;
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: (_) {
        if (controller!.text.isEmpty) {
          return AppStrings.validationsFieldRequired.tr();
        }
        return null;
      },
      builder: (errorContext) {
        return Container(
          margin: const EdgeInsets.symmetric(
            vertical: AppMargin.m5,
          ),
          padding: const EdgeInsets.all(AppPadding.p5),
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: errorContext.hasError
                      ? ColorManager.error
                      : ColorManager.black),
              color: ColorManager.lightBlack,
              borderRadius: BorderRadius.circular(AppSize.s18)),
          child: InkWell(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(children: [
                    Text(
                      title,
                      style: AppTextStyles.busesItemTripTitleTextStyle(context),
                    ),
                    if (icon != null) iconFunction!
                  ]),
                ),
                BusesTextField(
                  cursorColor: ColorManager.lightGrey,
                  hint: hintText,
                  readOnly: read,
                  focusNode: _focusNode,
                  validation: validation,
                  controller: controller,
                  textInputType: textInputType,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(inputFormatNumber),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
