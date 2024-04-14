import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/presentation/resources/assets_manager.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';

class UploadField extends StatelessWidget {
  const UploadField({
    super.key,
    required this.hint,
    required this.iconPath,
    required this.onPressed,
    required this.value,
  });

  final String hint;
  final String? value;
  final String iconPath;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    String? v;
    if (value != null) {
      v = value!.split('/').last;
    }
    return FormField(
      validator: (_) {
        if (value == null) {
          return AppStrings.validationsFieldRequired.tr();
        }
        return null;
      },
      initialValue: null,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: AppSize.s50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s10),
                border: Border.all(
                  color:
                      state.hasError ? ColorManager.error : ColorManager.white,
                  width: AppSize.s0_5,
                ),
              ),
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.transparent,
                  elevation: AppSize.s0,
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
                        v ?? hint,
                        style:
                            AppTextStyles.registerScreenTextFieldHintTextStyle(
                                context),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: v == null ? AppSize.s0 : AppSize.s20,
                      child: SvgPicture.asset(SVGAssets.checkmark),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: state.errorText == null ? AppSize.s0 : AppSize.s8,
            ),
            state.errorText == null
                ? const SizedBox()
                : Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: AppPadding.p8),
              child: Text(
                state.errorText!,
                style: AppTextStyles.textFieldErrorTextStyle(context),
              ),
            ),
          ],
        );
      },
    );
  }
}
