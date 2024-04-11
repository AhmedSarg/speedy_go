import 'package:flutter/material.dart';
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

class TripSearch extends StatelessWidget {
  const TripSearch({super.key});

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
              AppStrings.searchNearestDriver,
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
        Text(
          AppStrings.pleaseWait,
          style: AppTextStyles.SelectionTextStyle(
              context, ColorManager.black, FontSize.f22),
        ),
        const SizedBox(height: AppSize.s5),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.circle,
              size: AppSize.s12,
            ),
            Icon(
              Icons.circle,
              size: AppSize.s12,
            ),
            Icon(
              Icons.circle,
              size: AppSize.s12,
            ),
          ],
        ),
        const SizedBox(height: AppSize.s20),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.error,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s10),
            ),
            fixedSize: const Size(AppSize.s300, AppSize.s50),
          ),
          child: Text(
            AppStrings.cancel,
            style: AppTextStyles.SelectionTextStyle(
                context, ColorManager.white, FontSize.f22),
          ),
        ),
      ],
    );
  }
}
