import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:speedy_go/app/extensions.dart';

import '../../../../../../resources/assets_manager.dart';
import '../../../../../../resources/color_manager.dart';
import '../../../../../../resources/strings_manager.dart';
import '../../../../../../resources/text_styles.dart';
import '../../../../../../resources/values_manager.dart';
import '../../viewmodel/driver_trip_page_viewmodel.dart';

class WaitingSearchingForPassengers extends StatelessWidget {
  const WaitingSearchingForPassengers({super.key});

  static late DriverTripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = DriverTripViewModel.get(context);
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                AppStrings.waitingSearchingForPassengersScreenTitle.tr(),
                style: AppTextStyles
                    .waitingSearchingForPassengersScreenTitleTextStyle(context),
              ),
              Divider(
                color: ColorManager.grey.withOpacity(.5),
              ),
            ],
          ),
          const SizedBox(height: AppSize.s20),
          Text(
            AppStrings.waitingSearchingForPassengersScreenPleaseWait.tr(),
            style: AppTextStyles
                .waitingSearchingForPassengersScreenPleaseWaitTextStyle(
                    context),
          ),
          const SizedBox(height: AppSize.s10),
          Lottie.asset(LottieAssets.loadingDotsBlack),
          const SizedBox(height: AppSize.s20),
          SizedBox(
            width: context.width() / 1.5,
            height: context.width() / 10,
            child: ElevatedButton(
              onPressed: viewModel.toggleDriverStatus,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.error,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s10),
                ),
              ),
              child: Text(
                AppStrings.waitingSearchingForPassengersScreenButton.tr(),
                style: AppTextStyles
                    .waitingSearchingForPassengersScreenButtonTextStyle(
                        context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
