import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:speedy_go/presentation/driver_trip_screen/viewmodel/driver_trip_viewmodel.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';

class CardPassenger extends StatelessWidget {
  const CardPassenger({
    super.key,
    required this.passengerName,
    required this.tripTime,
    required this.tripDistance,
    required this.tripCost,
    required this.time,
    required this.passengerRate,
    this.id,
    this.widget,
  });

  final String passengerName;
  final int tripTime, tripDistance, tripCost, time;
  final int? id;
  final double passengerRate;
  final Widget? widget;

  static late DriverTripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = DriverTripViewModel.get(context);
    return Container(
      width: context.width(),
      decoration: BoxDecoration(
        color: ColorManager.grey,
        border: const Border(),
        borderRadius: BorderRadius.circular(AppSize.s25),
      ),
      child: Column(
        children: [
          const SizedBox(height: AppSize.s5),
          Stack(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: AppPadding.p10),
                child: CircleAvatar(
                  radius: AppSize.s40,
                  backgroundColor: ColorManager.transparent,
                  backgroundImage:
                      NetworkImage('https://via.placeholder.com/150'),
                ),
              ),
              Positioned(
                top: context.height() / 11,
                left: context.width() / 17,
                child: Container(
                  height: context.height() / 42,
                  width: context.width() / 10,
                  decoration: BoxDecoration(
                    border: const Border(),
                    borderRadius: BorderRadius.circular(AppSize.s25),
                    color: ColorManager.lightBlack,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "$passengerRate",
                        style: AppTextStyles
                            .acceptingPassengersScreenPassengerRateTextStyle(
                                context),
                      ),
                      SvgPicture.asset(SVGAssets.star)
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: AppSize.s5),
          Text(
            passengerName,
            style:
                AppTextStyles.acceptingPassengersScreenNameTextStyle(context),
          ),
          const SizedBox(height: AppSize.s5),
          Text(
            "Pickup is $time min away",
            style: AppTextStyles.acceptingPassengersScreenStartTimeTextStyle(
                context),
          ),
          const SizedBox(height: AppSize.s5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: AppPadding.p10),
                child: SvgPicture.asset(SVGAssets.cash),
              ),
              GestureDetector(
                onTap: () {
                  viewModel.nextPage();
                },
                child: Text(
                  "EGP $tripCost",
                  style: AppTextStyles.acceptingPassengersScreenCostTextStyle(
                      context),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSize.s5),
          Divider(color: ColorManager.black.withOpacity(.2)),
          const SizedBox(height: AppSize.s5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: AppPadding.p10),
                    child: SvgPicture.asset(SVGAssets.time),
                  ),
                  Text(
                    "$tripTime min",
                    style: AppTextStyles
                        .acceptingPassengersScreenTripTimeTextStyle(context),
                  ),
                ],
              ),
              VerticalDivider(
                color: ColorManager.black.withOpacity(.2),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: AppPadding.p10),
                    child: SvgPicture.asset(SVGAssets.routeSquare),
                  ),
                  Text(
                    "$tripDistance km",
                    style: AppTextStyles
                        .acceptingPassengersScreenTripDistanceTextStyle(
                            context),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSize.s10),
        ],
      ),
    );
  }
}
