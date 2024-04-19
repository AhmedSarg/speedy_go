import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:speedy_go/presentation/resources/assets_manager.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/driver_trip_viewmodel.dart';

class WaitingSearchingForPassengers extends StatelessWidget {
  const WaitingSearchingForPassengers({super.key});

  static late DriverTripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = DriverTripViewModel.get(context);
    return SizedBox(
      height: context.height() / 4,
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
          Text(
            AppStrings.waitingSearchingForPassengersScreenPleaseWait.tr(),
            style: AppTextStyles
                .waitingSearchingForPassengersScreenPleaseWaitTextStyle(
                    context),
          ),
          Lottie.asset(LottieAssets.loadingDotsBlack),
          SizedBox(
            width: context.width() / 1.5,
            height: context.width() / 10,
            child: ElevatedButton(
              onPressed: () {
                ///cancel search
                // viewModel.toggleShowContainer();
                viewModel.nextPage();
              },
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
