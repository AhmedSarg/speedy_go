import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:speedy_go/presentation/resources/assets_manager.dart';

import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';
import '../viewmodel/driver_trip_viewmodel.dart';
import 'widgets/status_button.dart';
import 'widgets/action_button.dart';

class DriverTripBody extends StatelessWidget {
  const DriverTripBody({
    super.key,
    required this.viewModel,
  });

  final DriverTripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        viewModel.prevPage();
      },
      child: SafeArea(
        child: SizedBox(
          width: AppSize.infinity,
          height: AppSize.infinity,
          child: Stack(
            children: [
              viewModel.getDriverStatus
                  ? GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: viewModel.getUserLocation,
                        zoom: AppSize.s18,
                      ),
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      style: viewModel.getMapStyle,
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(AppPadding.p50),
                        child: Lottie.asset(LottieAssets.areYouSure),
                      ),
                    ),
              viewModel.getDriverStatus
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: AppSize.infinity,
                          padding: const EdgeInsets.all(AppPadding.p16),
                          decoration: const BoxDecoration(
                            color: ColorManager.lightBlack,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppSize.s20),
                              topRight: Radius.circular(AppSize.s20),
                            ),
                          ),
                          child: viewModel.getPage,
                        ),
                      ],
                    )
                  : const SizedBox(),
              StatusButton(),
              (viewModel.getIndexPage != 5 &&
                  viewModel.getIndexPage != 0 &&
                  viewModel.getIndexPage != 1)
                  ? SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p10),
                  child: BackOrExit(
                    viewModel: viewModel,
                    onTap: () {
                      if (viewModel.getIndexPage == 4) {
                        viewModel.prevPage();
                      } else {
                        viewModel.reset();
                      }
                    },
                  ),
                ),
              )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
