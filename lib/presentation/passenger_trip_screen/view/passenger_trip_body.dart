import 'package:flutter/material.dart';

import '../../common/widget/main_back_button.dart';
import '../../resources/assets_manager.dart';
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
        children: [
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
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(AppPadding.p20),
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
            ),
          ),
        ],
      ),
    );
  }
}
