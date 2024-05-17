import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/app/extensions.dart';

import '../../../../../../resources/assets_manager.dart';
import '../../../../../../resources/color_manager.dart';
import '../../../../../../resources/text_styles.dart';
import '../../../../../../resources/values_manager.dart';
import '../../viewmodel/driver_trip_page_viewmodel.dart';

class CardPassenger extends StatelessWidget {
  const CardPassenger({
    super.key,
    required this.passengerName,
    required this.passengerImage,
    required this.tripTime,
    required this.tripDistance,
    required this.tripCost,
    required this.time,
    required this.passengerRate,
    this.id,
    this.widget,
  });

  final String passengerName, passengerImage;
  final int tripTime, tripDistance, tripCost, time;
  final int? id;
  final double passengerRate;
  final Widget? widget;

  static late DriverTripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = DriverTripViewModel.get(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      decoration: BoxDecoration(
        color: ColorManager.grey,
        borderRadius: BorderRadius.circular(AppSize.s25),
      ),
      child: FittedBox(
        child: SizedBox(
          width: context.width(),
          child: Column(
            children: [
              const SizedBox(height: AppSize.s5),
              Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppPadding.p10),
                    child: Container(
                      width: AppSize.s80,
                      height: AppSize.s80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorManager.white,
                          width: AppSize.s0_5,
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: passengerImage.contains('https')
                          ? CachedNetworkImage(
                              imageUrl: passengerImage,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder: (_, __, progress) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(AppSize.s25),
                                    child: CircularProgressIndicator(
                                      color: ColorManager.secondary,
                                      strokeWidth: AppSize.s1,
                                      strokeCap: StrokeCap.round,
                                    ),
                                  ),
                                );
                              },
                            )
                          : Image.asset(
                              passengerImage,
                              fit: BoxFit.cover,
                            ),
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
                            "${passengerRate.round()}",
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    passengerName,
                    style: AppTextStyles.acceptingPassengersScreenNameTextStyle(
                        context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  widget != null
                      ? SizedBox.square(
                          dimension: AppSize.s35,
                          child: widget,
                        )
                      : const SizedBox(),
                ],
              ),
              const SizedBox(height: AppSize.s5),
              Text(
                "Pickup is $time min away",
                style:
                    AppTextStyles.acceptingPassengersScreenStartTimeTextStyle(
                        context),
              ),
              const SizedBox(height: AppSize.s5),
              TextButton(
                onPressed:
                    viewModel.getIsAccepted ? null : viewModel.goToEditCost,
                style: TextButton.styleFrom(
                  foregroundColor: ColorManager.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: AppPadding.p10),
                      child: SvgPicture.asset(SVGAssets.cash),
                    ),
                    Text(
                      "EGP $tripCost",
                      style:
                          AppTextStyles.acceptingPassengersScreenCostTextStyle(
                              context),
                    ),
                  ],
                ),
              ),
              Divider(
                color: ColorManager.white.withOpacity(.5),
              ),
              const SizedBox(height: AppSize.s5),
              SizedBox(
                height: AppSize.s40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(SVGAssets.time),
                        const SizedBox(width: AppSize.s5),
                        Text(
                          "$tripTime min",
                          style: AppTextStyles
                              .acceptingPassengersScreenTripTimeTextStyle(
                                  context),
                        ),
                      ],
                    ),
                    VerticalDivider(
                      color: ColorManager.white.withOpacity(.5),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(SVGAssets.routeSquare),
                        const SizedBox(width: AppSize.s5),
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
              ),
              const SizedBox(height: AppSize.s10),
            ],
          ),
        ),
      ),
    );
  }
}
