import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speedy_go/domain/models/enums.dart';
import 'package:speedy_go/presentation/common/widget/main_back_button.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';
import 'package:speedy_go/presentation/resources/font_manager.dart';
import 'package:speedy_go/presentation/resources/strings_manager.dart';
import 'package:speedy_go/presentation/resources/styles_manager.dart';
import 'package:speedy_go/presentation/resources/text_styles.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

import '../../viewmodel/passenger_map_viewmodel.dart';

class PassengerMapLocation extends StatelessWidget {
  const PassengerMapLocation({
    super.key,
    required this.locationMapType,
  });

  static late PassengerMapViewModel viewModel;
  final LocationMapType locationMapType;

  @override
  Widget build(BuildContext context) {
    viewModel = PassengerMapViewModel.get(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        viewModel.exitMap();
      },
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: viewModel.getUserLocation,
              zoom: AppSize.s18,
            ),
            onMapCreated: (mapController) {
              viewModel.setMapController = mapController;
            },
            style: viewModel.getMapStyle,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Back(
                    onTap: () {
                      viewModel.exitMap();
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FloatingActionButton.small(
                        onPressed: () {
                          viewModel.getMapController.animateCamera(
                            CameraUpdate.newLatLng(viewModel.getUserLocation),
                          );
                        },
                        backgroundColor: ColorManager.lightGrey,
                        foregroundColor: ColorManager.white,
                        shape: const CircleBorder(),
                        splashColor: ColorManager.primary.withOpacity(.1),
                        elevation: AppSize.s10,
                        child: const Icon(
                          Icons.gps_fixed_outlined,
                          size: AppSize.s20,
                        ),
                      ),
                      const SizedBox(height: AppSize.s30),
                      SizedBox(
                        width: AppSize.infinity,
                        height: AppSize.s50,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            AppStrings.tripMapScreenDone.tr(),
                            style: AppTextStyles.tripMapScreenMapButtonTextStyle(
                                context),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
