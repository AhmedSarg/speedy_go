import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/app/extensions.dart';

import '../../../../domain/models/enums.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/passenger_trip_viewmodel.dart';

class TripConfirm extends StatelessWidget {
  const TripConfirm({super.key});

  static late PassengerTripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = PassengerTripViewModel.get(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              AppStrings.tripScreenVehicleSelectionPageTitle.tr(),
              style: AppTextStyles.tripScreenConfirmPageTitleTextStyle(
                  context),
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
                color: ColorManager.darkBlack),
            child: Column(
              children: [
                const Spacer(),
                FittedBox(
                  child: SvgPicture.asset(
                    viewModel.getTripType == TripType.car
                        ? SVGAssets.car
                        : SVGAssets.tuktuk,
                  ),
                ),
                const Spacer(),
                Text(
                  viewModel.getTripType == TripType.car
                      ? AppStrings.tripScreenConfirmPageCar.tr()
                      : AppStrings.tripScreenConfirmPageTukTuk.tr(),
                  style: AppTextStyles
                      .tripScreenConfirmPageVehicleTypeTextStyle(context),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Text(
              "EGP ${viewModel.getPrice}, cash",
              style: AppTextStyles
                  .tripScreenConfirmPageRecommendedFareTextStyle(context),
            ),
            Text(
              AppStrings.tripScreenConfirmPageDescription.tr(),
              style:
                  AppTextStyles.tripScreenConfirmPageDescriptionTextStyle(
                      context),
            ),
            const Divider(
              color: ColorManager.black,
              indent: AppSize.s50,
              endIndent: AppSize.s50,
            ),
            SizedBox(
              height: AppSize.s50,
              child: Row(
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
                        AppStrings.tripScreenConfirmPageCancel.tr(),
                        style: AppTextStyles
                            .tripScreenConfirmPageButtonTextStyle(context),
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
                        AppStrings.tripScreenConfirmPageNext.tr(),
                        style: AppTextStyles
                            .tripScreenConfirmPageButtonTextStyle(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
