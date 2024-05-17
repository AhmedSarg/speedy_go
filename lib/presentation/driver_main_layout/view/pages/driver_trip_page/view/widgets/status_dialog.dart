import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speedy_go/app/extensions.dart';

import '../../../../../../resources/color_manager.dart';
import '../../../../../../resources/strings_manager.dart';
import '../../../../../../resources/text_styles.dart';
import '../../../../../../resources/values_manager.dart';
import '../../viewmodel/driver_trip_page_viewmodel.dart';

class StatusDialog extends StatelessWidget {
  const StatusDialog({super.key, required this.viewModel});

  final DriverTripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    String toggleStateText = viewModel.getDriverStatus
        ? AppStrings.driverTripScreenStatusOffline
        : AppStrings.driverTripScreenStatusOnline;
    String titleText = viewModel.getDriverStatus
        ? AppStrings.driverTripScreenStatusOnlineDialogTitle
        : AppStrings.driverTripScreenStatusOfflineDialogTitle;
    Color toggleStatusColor = viewModel.getDriverStatus
        ? ColorManager.error
        : ColorManager.lightGreen;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: context.width() * .7,
          padding: const EdgeInsets.all(AppPadding.p30),
          decoration: const BoxDecoration(
            color: ColorManager.primary,
            borderRadius: BorderRadius.all(
              Radius.circular(AppSize.s20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                titleText.tr(),
                style:
                    AppTextStyles.runModeScreenTitleContainerTextStyle(context),
              ),
              const SizedBox(height: AppSize.s20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.driverTripScreenStatusTurnInto.tr(),
                    style:
                        AppTextStyles.runModeScreenTurnIntoTextStyle(context),
                  ),
                  const SizedBox(width: AppSize.s5),
                  SizedBox(
                    height: AppSize.s30,
                    child: ElevatedButton(
                      onPressed: () {
                        viewModel.toggleDriverStatus();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: toggleStatusColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppSize.s15),
                          ),
                        ),
                      ),
                      child: Text(
                        "${toggleStateText.tr()} Mode",
                        style:
                            AppTextStyles.runModeScreenModeTextStyle(context),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: AppSize.s20),
              Container(
                width: context.width(),
                height: AppSize.s30,
                padding: const EdgeInsets.symmetric(horizontal: AppSize.s50),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.error,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s12),
                    ),
                  ),
                  child: Text(
                      AppStrings.driverTripScreenStatusDialogButton.tr(),
                      style: AppTextStyles.runModeScreenButtonCloseTextStyle(
                          context)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
