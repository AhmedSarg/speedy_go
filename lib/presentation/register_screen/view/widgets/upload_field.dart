import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';

class UploadField extends StatelessWidget {
  const UploadField({
    super.key,
    required this.hint,
    required this.iconPath,
  });

  final String hint;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s10),
        border: Border.all(
          color: ColorManager.white,
          width: AppSize.s0_5,
        ),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.only(right: AppPadding.p5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: AppSize.s30,
              child: SvgPicture.asset(iconPath),
            ),
            Expanded(
              child: Text(
                hint,
                style: AppTextStyles.registerScreenTextFieldHintTextStyle(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
