import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../resources/color_manager.dart';
import '../../../../../resources/values_manager.dart';
import '../viewmodel/driver_trip_page_viewmodel.dart';
import 'widgets/status_button.dart';

class DriverTripBody extends StatefulWidget {
  const DriverTripBody({
    super.key,
    required this.viewModel,
  });

  final DriverTripViewModel viewModel;

  @override
  State<DriverTripBody> createState() => _DriverTripBodyState();
}

class _DriverTripBodyState extends State<DriverTripBody> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        print(88);
      },
      child: Scaffold(
        body: SizedBox(
          height: AppSize.infinity,
          width: AppSize.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: widget.viewModel.getUserLocation,
                          zoom: AppSize.s18,
                        ),
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                        polylines: widget.viewModel.getPolyline,
                        markers: widget.viewModel.getMarkers,
                        style: widget.viewModel.getMapStyle,
                        onMapCreated: (controller) {
                          widget.viewModel.setMapController = controller;
                        },
                      ),
                    ),
                    widget.viewModel.getPageIndex <= 0
                        ? StatusButton()
                        : const SizedBox(),
                  ],
                ),
              ),
              widget.viewModel.getDriverStatus
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
                      child: widget.viewModel.getPage,
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
