import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_go/domain/models/enums.dart';
import 'package:speedy_go/presentation/common/data_intent/data_intent.dart';
import 'package:speedy_go/presentation/common/widget/main_button.dart';
import 'package:speedy_go/presentation/resources/routes_manager.dart';
import 'package:speedy_go/presentation/resources/text_styles.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/values_manager.dart';

class SelectionBody extends StatelessWidget {
  const SelectionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p100),
              child: SvgPicture.asset(SVGAssets.logo),
            ),
          ),
          const SelectionBox(),
        ],
      ),
    );
  }
}

class SelectionBox extends StatelessWidget {
  const SelectionBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppMargin.m20,
        vertical: AppMargin.m40,
      ),
      padding: const EdgeInsets.all(AppPadding.p50),
      width: AppSize.infinity,
      decoration: BoxDecoration(
        color: ColorManager.primary.withOpacity(.5),
        borderRadius: BorderRadius.circular(AppSize.s25),
      ),
      child: Column(
        children: [
          AppButton(
            text: 'Driver',
            onPressed: () {
              Navigator.pushNamed(context, Routes.registerRoute);
              DataIntent.setSelection(UserType.driver);
            },
            textStyle: AppTextStyles.selectionScreenButtonTextStyle(context),
          ),
          const SizedBox(height: AppSize.s50),
          AppButton(
            text: 'Passeneger',
            onPressed: () {
              Navigator.pushNamed(context, Routes.registerRoute);
              DataIntent.setSelection(UserType.passenger);
            },
            textStyle: AppTextStyles.selectionScreenButtonTextStyle(context),
          ),
        ],
      ),
    );
  }
}
