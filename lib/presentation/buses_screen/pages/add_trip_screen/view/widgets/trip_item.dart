import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speedy_go/presentation/resources/text_styles.dart';

import '../../../../../common/widget/options_menu.dart';
import '../../../../../resources/color_manager.dart';
import '../../../../../resources/values_manager.dart';
import '../../../../view/widgets/text_field.dart';

class TripItem extends StatelessWidget {
  const TripItem(
      {super.key,
      required this.title,
      required this.hintText,
      required this.read,
      required this.textInputType,
      this.onTap,
      this.icon,
      this.inputFormatNumber,
      this.IconFunction, this.controller});
  final String title;
  final String hintText;
  final bool read;
  final TextInputType textInputType;
  final void Function()? onTap;
  final Widget? IconFunction;
  final IconData? icon;
  final int? inputFormatNumber;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppSize.s100,
        margin: const EdgeInsets.all(AppMargin.m5),
        padding: const EdgeInsets.all(AppPadding.p5),
        decoration: BoxDecoration(
            color: ColorManager.offwhite,
            borderRadius: BorderRadius.circular(AppSize.s18)),
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
                if (icon != null)
                  IconFunction!

              ]),
            ),
            BusesTextField(
              cursorColor: ColorManager.lightGrey,
              hint: hintText,
              readOnly: read,
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
  }
}
