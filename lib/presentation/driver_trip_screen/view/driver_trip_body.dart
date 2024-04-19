import 'package:flutter/material.dart';
import 'package:speedy_go/presentation/driver_trip_screen/view/pages/accept_ride_page.dart';
import 'package:speedy_go/presentation/driver_trip_screen/view/pages/run_mode_page.dart';
import 'package:speedy_go/presentation/driver_trip_screen/view/pages/running_trip.dart';
import 'package:speedy_go/presentation/driver_trip_screen/view/pages/trip_edit_cost.dart';
import 'package:speedy_go/presentation/driver_trip_screen/view/pages/waiting_page.dart';

import '../../common/widget/main_back_button.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';
import '../viewmodel/driver_trip_viewmodel.dart';

class DriverTripBody extends StatelessWidget {
  const DriverTripBody({
    super.key,
    required this.viewModel,
  });

  final DriverTripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // canPop: viewModel.getCanPop,
      onPopInvoked: (_) {
        // viewModel.prevPage();
      },
      child: Stack(
        children: [
          /// Background Image
          Scaffold(
            resizeToAvoidBottomInset: false,
            body: SizedBox(
              height: AppSize.infinity,
              width: AppSize.infinity,
              child: Image.asset(
                ImageAssets.loginBackgroundImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: ColorManager.transparent,
            body: SizedBox(
              width: AppSize.infinity,
              height: AppSize.infinity,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RunMode(
                      viewModel: viewModel,
                    ),
                    viewModel.getMode
                        ? Container(
                            width: AppSize.infinity,
                            padding: const EdgeInsets.all(AppPadding.p16),
                            decoration: const BoxDecoration(
                              color: ColorManager.lightBlack,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(AppSize.s20),
                                topRight: Radius.circular(AppSize.s20),
                              ),
                            ),
                            child: const RunningTrip()
                            // child: viewModel.getPage,
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
