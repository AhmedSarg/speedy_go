import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:speedy_go/presentation/driver_trip_screen/view/pages/run_mode_page.dart';
import 'package:speedy_go/presentation/driver_trip_screen/view/widgets/botton_back.dart';

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
      onPopInvoked: (_) {
        viewModel.prevPage();
      },
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: true,
            // body: Container(
            //     height: AppSize.infinity,
            //     width: AppSize.infinity,
            //     padding: EdgeInsets.only(bottom: context.height() * .3),
            //     child: GoogleMap(
            //       initialCameraPosition: CameraPosition(
            //         target: viewModel.getPickupLocation,
            //         zoom: AppSize.s17,
            //       ),
            //       style: viewModel.getMapStyle,
            //       myLocationEnabled: true,
            //       myLocationButtonEnabled: false,
            //       compassEnabled: false,
            //       mapToolbarEnabled: false,
            //       zoomControlsEnabled: false,
            //     )
            // ),

            bottomSheet: (viewModel.getIndexPage != 0)
                ? Column(
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
                  )
                : const SizedBox.shrink(),
          ),
          (viewModel.getIndexPage == 0)
              ? Scaffold(
                  resizeToAvoidBottomInset: true,
                  backgroundColor: ColorManager.transparent,
                  body: SizedBox(
                    width: AppSize.infinity,
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RunMode(),
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
                                  child: viewModel.getPage,
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
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
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
