import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speedy_go/app/extensions.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';
import '../../../resources/text_styles.dart';
import '../../viewmodel/driver_trip_viewmodel.dart';

class RunMode extends StatelessWidget {
  const RunMode({super.key, required this.viewModel});

  final DriverTripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
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
        child: StatusButton(
          status: statusText,
          color: statusColor,
          onTap: viewModel.toggleChangeStatusDialog,
        ),
      ),
    );
  }
}

class StatusButton extends StatelessWidget {
  const StatusButton({
    super.key,
    required this.status,
    required this.color,
    required this.onTap,
  });

  final String status;
  final Color color;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width() / 4,
      height: AppSize.s30,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s10))),
        ),
        child: Text(
          status.tr(),
          style: AppTextStyles.runModeScreenModeTextStyle(context),
        ),
      ),
    );
  }
}
