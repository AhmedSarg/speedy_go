import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:speedy_go/presentation/driver_trip_screen/viewmodel/driver_trip_viewmodel.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../widgets/card_passenger.dart';

class TripEnd extends StatelessWidget {
  const TripEnd({super.key});

  static late DriverTripViewModel viewModel;


  @override
  Widget build(BuildContext context) {
    viewModel = DriverTripViewModel.get(context);
    return SizedBox(
      height: context.height() / 2.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(AppStrings.endTripScreenTitle.tr(),style: AppTextStyles.endTripScreenTitleTextStyle(context),),
              Divider(
                color: ColorManager.grey.withOpacity(.5),
              ),
            ],
          ),
          CardPassenger(
            passengerName: "ahmed",
            tripTime: 6,
            tripDistance: 3,
            tripCost: 30,
            time: 12,
            passengerRate: 3.3,
            widget: IconButton(
              icon: SvgPicture.asset(SVGAssets.fillPhone),
              onPressed: () {
                // launchUrlString('tel://${viewModel.getSelectedDriver.phoneNumber}');
                launchUrlString('tel://011');
              },
            ),
          ),
          SizedBox(
            width: context.width() / 2,
            height: context.width() / 10,
            child: ElevatedButton(
              onPressed: () {
                ///EndTrip
                viewModel.nextPage();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s10),
                ),
              ),
              child: Text(
                AppStrings.endTripScreenButton.tr(),
                style: AppTextStyles
                    .endTripScreenButtonTextStyle(
                    context),
              ),
            ),
          )
        ],
      ),
    );
  }
}
