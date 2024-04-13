import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../domain/models/enums.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/passenger_map_viewmodel.dart';

class PassengerMapPermissions extends StatelessWidget {
  const PassengerMapPermissions({
    super.key,
    required this.locationError,
    required this.viewModel,
  });

  final LocationError locationError;
  final PassengerMapViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          children: [
            const Spacer(),
            SizedBox.square(
              dimension: AppSize.s200,
              child: Lottie.asset(LottieAssets.location),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p10,
                    vertical: AppPadding.p5,
                  ),
                  child: Text(
                    locationError == LocationError.services
                        ? 'Location Service is Disabled'
                        : 'Location Permissions is Disabled',
                    style: getBoldStyle(
                        color: ColorManager.secondary, fontSize: FontSize.f22),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p30, vertical: AppPadding.p5),
                  child: Text(
                    locationError == LocationError.services
                        ? 'we need location service enabled in order to get your location to send you a vehicle.'
                        : 'we need location permissions in order to get your location to send you a vehicle.',
                    style: getRegularStyle(
                        color: ColorManager.white, fontSize: FontSize.f10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const Spacer(flex: 2),
            SizedBox(
              width: AppSize.infinity,
              height: AppSize.s50,
              child: ElevatedButton(
                onPressed: locationError == LocationError.services
                    ? viewModel.askForLocationServices
                    : viewModel.askForLocationPermissions,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.secondary,
                  foregroundColor: ColorManager.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s20),
                  ),
                ),
                child: Text(
                  'Open Settings',
                  style: getSemiBoldStyle(
                    color: ColorManager.white,
                    fontSize: FontSize.f22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
