import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speedy_go/app/extensions.dart';

import '../../common/widget/main_back_button.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';
import '../viewmodel/passenger_trip_viewmodel.dart';

class PassengerTripBody extends StatelessWidget {
  const PassengerTripBody({
    super.key,
    required this.viewModel,
  });

  final PassengerTripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: viewModel.getCanPop,
      onPopInvoked: (_) {
        viewModel.prevPage();
      },
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Scaffold(
            resizeToAvoidBottomInset: true,
            body: Container(
              height: AppSize.infinity,
              width: AppSize.infinity,
              padding: EdgeInsets.only(bottom: context.height() * .3),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: viewModel.getPickupLocation,
                  zoom: AppSize.s17,
                ),
                style: viewModel.getMapStyle,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                compassEnabled: false,
                mapToolbarEnabled: false,
                zoomControlsEnabled: false,
              )
            ),
            bottomSheet: Column(
              mainAxisSize: MainAxisSize.min,
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
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p10),
              child: Back(
                onTap: () {
                  if (viewModel.getCanPop) {
                    Navigator.pop(context);
                  } else {
                    viewModel.prevPage();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
