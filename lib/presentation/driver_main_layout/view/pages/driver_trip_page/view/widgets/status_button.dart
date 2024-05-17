import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speedy_go/app/extensions.dart';

import '../../../../../../resources/color_manager.dart';
import '../../../../../../resources/strings_manager.dart';
import '../../../../../../resources/text_styles.dart';
import '../../../../../../resources/values_manager.dart';
import '../../viewmodel/driver_trip_page_viewmodel.dart';

class StatusButton extends StatelessWidget {
  const StatusButton({super.key});

  static late DriverTripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = DriverTripViewModel.get(context);
    String statusText = viewModel.getDriverStatus
        ? AppStrings.driverTripScreenStatusOnline
        : AppStrings.driverTripScreenStatusOffline;
    Color statusColor = viewModel.getDriverStatus
        ? ColorManager.lightGreen
        : ColorManager.error;
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: const EdgeInsets.all(AppMargin.m20),
        child: SizedBox(
          width: context.width() / 4,
          height: AppSize.s30,
          child: ElevatedButton(
            onPressed: viewModel.toggleChangeStatusDialog,
            style: ElevatedButton.styleFrom(
              backgroundColor: statusColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(AppSize.s10))),
            ),
            child: Text(
              statusText.tr(),
              style: AppTextStyles.runModeScreenModeTextStyle(context),
            ),
          ),
        ),
      ),
    );
  }
}
