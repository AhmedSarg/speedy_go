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
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: AppSize.infinity,
            width: AppSize.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: viewModel.getUserLocation,
                          zoom: AppSize.s18,
                        ),
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                        polylines: viewModel.getPolyline,
                        markers: viewModel.getMarkers,
                        style: viewModel.getMapStyle,
                        onMapCreated: (controller) {
                          viewModel.setMapController = controller;
                        },
                      ),
                      viewModel.getPageIndex <= 0
                          ? StatusButton()
                          : const SizedBox(),
                    ],
                  ),
                ),
                viewModel.getDriverStatus
                    ? Container(
                        width: AppSize.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: AppPadding.p20,
                          horizontal: AppSize.s0,
                        ),
                        decoration: const BoxDecoration(
                          color: ColorManager.lightBlack,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppSize.s20),
                            topRight: Radius.circular(AppSize.s20),
                          ),
                        ),
                        child: viewModel.getPage,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
