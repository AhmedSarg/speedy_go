import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:speedy_go/presentation/driver_trip_screen/viewmodel/driver_trip_viewmodel.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';

class CardPassenger extends StatelessWidget {
  const CardPassenger(
      {super.key,
      required this.passengerName,
      required this.tripTime,
      required this.tripDistance,
      required this.tripCost,
      required this.time,
      required this.passengerRate,
      this.id,
      this.widget});
  //add Image Profile
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
      height: context.height() / 3.35,
      width: context.width() / 1.28,
      decoration: BoxDecoration(
        color: ColorManager.grey,
        border: const Border(),
        borderRadius: BorderRadius.circular(AppSize.s25),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: AppPadding.p10),
            child: Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppPadding.p10),
                  child: CircleAvatar(
                    radius: AppSize.s40,
                    backgroundColor: ColorManager.transparent,
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/150'),
                    /// Image Profile
                  ),
                ),
                Positioned(
                  top: context.height() / 11,
                  left: context.width() / 18.5,
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
          ),
          Row(
            children: [
              const Spacer(),
              Text(
                passengerName,
                // "$passengerName id:$id",//for test
                style: AppTextStyles.acceptingPassengersScreenNameTextStyle(
                    context),
              ),
              widget ?? const SizedBox.shrink(), //(widget == null) ==> sizedBox
              const Spacer(),
            ],
          ),
          Text(
            "Pickup is $time min away",
            style: AppTextStyles.acceptingPassengersScreenStartTimeTextStyle(
                context),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: AppPadding.p10),
                child: SvgPicture.asset(SVGAssets.cash),
              ),
              GestureDetector(
                onTap: () {
                  ///goto edit cost page
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
          Divider(
            color: ColorManager.black.withOpacity(.2),
            endIndent: context.width() / 6,
            indent: context.width() / 6,
          ),
          //for show VerticalDivider
          IntrinsicHeight(
            child: Row(
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
