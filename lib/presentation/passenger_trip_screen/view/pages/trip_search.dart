import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:speedy_go/app/extensions.dart';

import '../../../../../domain/models/enums.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/passenger_trip_viewmodel.dart';

class TripSearch extends StatelessWidget {
  const TripSearch({super.key});

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
              AppStrings.tripScreenSearchPageTitle.tr(),
              style: AppTextStyles.tripScreenSearchPageTitleTextStyle(context),
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
              color: ColorManager.darkBlack,
            ),
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
                      ? AppStrings.tripScreenSearchPageCar.tr()
                      : AppStrings.tripScreenSearchPageTukTuk.tr(),
                  style: AppTextStyles.tripScreenSearchPageVehicleTypeTextStyle(
                      context),
                ),
              ],
            ),
          ),
        ),
        Text(
          AppStrings.tripScreenSearchPagePleaseWait.tr(),
          style: AppTextStyles.tripScreenSearchPagePleaseWaitTextStyle(context),
        ),
        const SizedBox(height: AppSize.s5),
        Lottie.asset(LottieAssets.loadingDotsBlack),
        const SizedBox(height: AppSize.s20),
        SizedBox(
          height: AppSize.s50,
          width: AppSize.infinity,
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
              AppStrings.tripScreenSearchPageCancel.tr(),
              style: AppTextStyles.tripScreenSearchPageButtonTextStyle(context),
            ),
          ),
        ),
      ],
    );
  }
}
