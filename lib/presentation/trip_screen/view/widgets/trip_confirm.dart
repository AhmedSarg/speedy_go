import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/app/extensions.dart';

import '../../../../domain/models/enums.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/trip_viewmodel.dart';

class TripConfirm extends StatelessWidget {
  const TripConfirm({super.key});

  static late TripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = TripViewModel.get(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              AppStrings.chooseYourVehicle,
              style: AppTextStyles.SelectionTextStyle(
                  context, ColorManager.black, FontSize.f22),
            ),
            const Divider(
              color: ColorManager.black,
              indent: AppSize.s20,
              endIndent: AppSize.s20,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p20),
          child: Container(
            padding: const EdgeInsets.all(AppPadding.p10),
            height: context.width() * .5,
            width: context.width() * .5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s20),
              border: Border.all(color: ColorManager.black),
              color: ColorManager.darkBlack
            ),
            child: Column(
              children: [
                const Spacer(),
                FittedBox(
                  child: SvgPicture.asset(
                    viewModel.getTripType == TripType.car ? SVGAssets.car : SVGAssets.tuktuk,
                  ),
                ),
                const Spacer(),
                Text(
                  viewModel.getTripType == TripType.car ? 'Car' : 'Tuktuk',
                  style: AppTextStyles.SelectionTextStyle(
                      context, ColorManager.white, FontSize.f22),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Text(
              "EGP 50, cash",
              style: AppTextStyles.SelectionTextStyle(
                  context, ColorManager.black, FontSize.f18),
            ),
            Text(
              "Recommended fare, adjustable",
              style: AppTextStyles.SelectionTextStyle(
                  context, ColorManager.black, FontSize.f10),
            ),
            const Divider(
              color: ColorManager.black,
              indent: AppSize.s50,
              endIndent: AppSize.s50,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      viewModel.prevPage();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.error,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s10),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: AppTextStyles.SelectionTextStyle(
                          context, ColorManager.white, FontSize.f22),
                    ),
                  ),
                ),
                const SizedBox(width: AppSize.s10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      viewModel.nextPage();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s10),
                      ),
                    ),
                    child: Text(
                      'Next',
                      style: AppTextStyles.SelectionTextStyle(
                          context, ColorManager.white, FontSize.f22),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
