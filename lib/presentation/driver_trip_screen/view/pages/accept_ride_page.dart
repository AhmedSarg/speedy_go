import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:speedy_go/app/extensions.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/driver_trip_viewmodel.dart';
import '../widgets/card_passenger.dart';

class AcceptRide extends StatelessWidget {
  const AcceptRide({super.key});

  static late DriverTripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = DriverTripViewModel.get(context);
    print(viewModel.getIsAccepted);
    return SizedBox(
      height: context.height() / 2,
      child: Column(
        children: [
          Column(
            children: [
              Text(
                AppStrings.acceptingPassengersScreenTitle.tr(),
                style: AppTextStyles
                    .acceptingPassengersScreenPassengerTitleTextStyle(context),
              ),
              Divider(
                color: ColorManager.grey.withOpacity(.5),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  //back
                  viewModel.updateIndexPassenger(false);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: ColorManager.white,
                ),
              ),
              CardPassenger(
                passengerRate: 3.5,
                passengerName: "ahmed",
                time: 6,
                tripCost: 30,
                tripTime: 12,
                tripDistance: 3,
                id: viewModel.getIndexPassenger,
              ),
              GestureDetector(
                onTap: () {
                  //next
                  viewModel.updateIndexPassenger(true);
                },
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: ColorManager.white,
                ),
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: SizedBox(
              width: context.width() / 2,
              height: context.width() / 10,
              child: ElevatedButton(
                onPressed: !viewModel.getIsAccepted
                    ? () {
                        ///Accept Ride
                        viewModel.setIsAccepted = true;
                        // viewModel.nextPage();
                        // viewModel.updatePage(1);
                        // print(viewModel.getIsAccepted);
                        // print(viewModel.getIndexPage);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.lightBlue,
                  disabledBackgroundColor:
                      ColorManager.lightBlue.withOpacity(.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s10),
                  ),
                ),
                child: viewModel.getIsAccepted
                    ? Lottie.asset(LottieAssets.loadingDotsWhite)
                    : Text(
                        AppStrings.acceptingPassengersScreenButtonAccept.tr(),
                        style: AppTextStyles
                            .acceptingPassengersScreenButtonTextStyle(context),
                      ),
              ),
            ),
          ),
          viewModel.getIsAccepted
              ? SizedBox(
                  width: context.width() / 2,
                  height: context.width() / 10,
                  child: ElevatedButton(
                    onPressed: () {
                      ///cancel Ride
                      viewModel.setIsAccepted= false;
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.error,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s10),
                      ),
                    ),
                    child: Text(
                      AppStrings.acceptingPassengersScreenButtonCancel.tr(),
                      style: AppTextStyles
                          .acceptingPassengersScreenButtonTextStyle(context),
                    ),
                  ),
                )
              : const Spacer(),
        ],
      ),
    );
  }
}
