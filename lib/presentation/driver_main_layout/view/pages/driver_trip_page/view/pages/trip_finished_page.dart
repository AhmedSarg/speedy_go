import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../../resources/assets_manager.dart';
import '../../../../../../resources/color_manager.dart';
import '../../../../../../resources/strings_manager.dart';
import '../../../../../../resources/text_styles.dart';
import '../../../../../../resources/values_manager.dart';
import '../../viewmodel/driver_trip_page_viewmodel.dart';
import '../widgets/card_passenger.dart';

class TripEnd extends StatelessWidget {
  const TripEnd({super.key});

  static late DriverTripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = DriverTripViewModel.get(context);
    return Column(
      children: [
        Column(
          children: [
            Text(
              AppStrings.endTripScreenTitle.tr(),
              style: AppTextStyles.endTripScreenTitleTextStyle(context),
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
            tripCost: viewModel.getNewCost ?? viewModel.getSelectedTrip.price,
            time: viewModel.getSelectedTrip.awayMins,
            passengerRate: viewModel.getSelectedTrip.passengerRate,
            widget: IconButton(
              icon: SvgPicture.asset(SVGAssets.fillPhone),
              onPressed: () {
                launchUrlString(
                    'tel://${viewModel.getSelectedTrip.passengerPhoneNumber}');
                // launchUrlString('tel://011');
              },
            ),
          ),
        ),
        SizedBox(
          width: context.width() / 2,
          child: ElevatedButton(
            onPressed: viewModel.ratePassenger,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s10),
              ),
            ),
            child: Text(
              AppStrings.endTripScreenButton.tr(),
              style: AppTextStyles.endTripScreenButtonTextStyle(context),
            ),
          ),
        )
      ],
    );
  }
}
