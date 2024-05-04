import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:speedy_go/presentation/driver_trip_screen/view/widgets/card_passenger.dart';
import 'package:speedy_go/presentation/resources/assets_manager.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/driver_trip_viewmodel.dart';

class RunningTrip extends StatelessWidget {
  const RunningTrip({super.key});

  static late DriverTripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = DriverTripViewModel.get(context);
    return Column(
      children: [
        Column(
          children: [
            Text(
              AppStrings.runningTripScreenTitle.tr(),
              style: AppTextStyles.runningTripScreenTitleTextStyle(context),
            ),
            Divider(
              color: ColorManager.grey.withOpacity(.5),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p20,
            vertical: AppSize.s10,
          ),
          child: CardPassenger(
            passengerName: viewModel.getSelectedTrip.passengerName,
            passengerImage: viewModel.getSelectedTrip.imagePath,
            tripTime: viewModel.getSelectedTrip.expectedTime,
            tripDistance: viewModel.getSelectedTrip.distance,
            tripCost: viewModel.getSelectedTrip.price,
            time: viewModel.getSelectedTrip.awayMins,
            passengerRate: viewModel.getSelectedTrip.passengerRate,
            widget: IconButton(
              icon: SvgPicture.asset(SVGAssets.fillPhone),
              onPressed: () {
                launchUrlString('tel://${viewModel.getSelectedTrip.passengerPhoneNumber}');
                // launchUrlString('tel://011');
              },
            ),
          ),
        ),
        SizedBox(
          width: context.width() / 2,
          child: ElevatedButton(
            onPressed: () {
              viewModel.prevPage();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s10),
              ),
            ),
            child: Text(
              AppStrings.runningTripScreenButton.tr(),
              style: AppTextStyles.runningTripScreenButtonTextStyle(context),
            ),
          ),
        ),
      ],
    );
  }
}
