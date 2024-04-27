import 'package:flutter/material.dart';
import 'package:speedy_go/presentation/driver_trip_screen/view/pages/offline_page.dart';

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
                    viewModel.getDriverStatus
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
          ),
        ],
      ),
    );
  }
}
