import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:speedy_go/app/extensions.dart';

import '../../../../domain/models/domain.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/driver_trip_viewmodel.dart';
import '../widgets/card_passenger.dart';
import 'waiting_page.dart';

class AcceptRide extends StatelessWidget {
  const AcceptRide({super.key});

  static late DriverTripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = DriverTripViewModel.get(context);
    return StreamBuilder(
      stream: viewModel.getTripsStream,
      builder: (context, snapshot) {
        print(snapshot.data);
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          print('stream');
          return SizedBox(
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                      AppStrings.acceptingPassengersScreenTitle.tr(),
                      style: AppTextStyles
                          .acceptingPassengersScreenPassengerTitleTextStyle(context),
                    ),
                    Divider(
                      color: ColorManager.grey.withOpacity(.5),
                    ),
                  ],
                ),
                const SizedBox(height: AppSize.s10),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: context.width(),
                      child: CarouselSlider(
                        carouselController: viewModel.getCarouselController,
                        items: snapshot.data!.map(
                              (futureTrip) {
                            return FutureBuilder<TripPassengerModel>(
                              future: futureTrip,
                              builder: (context, future) {
                                if (future.hasData) {
                                  TripPassengerModel tripModel = future.data!;
                                  return CardPassenger(
                                    passengerName: tripModel.passengerName,
                                    passengerImage: tripModel.imagePath,
                                    passengerRate: tripModel.passengerRate,
                                    time: tripModel.awayMins,
                                    tripCost: tripModel.price,
                                    tripDistance: tripModel.distance,
                                    tripTime: tripModel.expectedTime,
                                  );
                                } else {
                                  return Center(
                                    child: Lottie.asset(LottieAssets.loading),
                                  );
                                }
                              },
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          initialPage: viewModel.getTripIndex,
                          scrollPhysics: viewModel.getIsAccepted
                              ? const NeverScrollableScrollPhysics()
                              : null,
                          viewportFraction: 1,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: viewModel.handleSelectedTrip,
                        ),
                      ),
                    ),
                    viewModel.getTripIndex != 0 && !viewModel.getIsAccepted
                        ? Padding(
                      padding: const EdgeInsets.only(left: AppSize.s5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox.square(
                          dimension: AppSize.s30,
                          child: IconButton(
                            onPressed: viewModel.prevTrip,
                            icon: const Icon(Icons.arrow_back_ios),
                            iconSize: AppSize.s20,
                            padding: const EdgeInsets.only(left: AppSize.s8),
                          ),
                        ),
                      ),
                    )
                        : const SizedBox(),
                    viewModel.getTripIndex != viewModel.getTripsList.length - 1 &&
                        !viewModel.getIsAccepted
                        ? Padding(
                      padding: const EdgeInsets.only(right: AppSize.s5),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox.square(
                          dimension: AppSize.s30,
                          child: IconButton(
                            onPressed: viewModel.nextTrip,
                            icon: const Icon(Icons.arrow_forward_ios),
                            iconSize: AppSize.s20,
                            padding: const EdgeInsets.only(left: AppSize.s4),
                          ),
                        ),
                      ),
                    )
                        : const SizedBox(),
                  ],
                ),
                const SizedBox(height: AppSize.s20),
                SizedBox(
                  width: context.width() / 2,
                  child: ElevatedButton(
                    onPressed: !viewModel.getIsAccepted ? viewModel.acceptTrip : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.lightBlue,
                      disabledBackgroundColor: ColorManager.lightBlue.withOpacity(.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s10),
                      ),
                    ),
                    child: viewModel.getIsAccepted
                        ? Lottie.asset(LottieAssets.loadingDotsWhite)
                        : Text(
                      AppStrings.acceptingPassengersScreenButtonAccept.tr(),
                      style: AppTextStyles
                          .acceptingPassengersScreenButtonTextStyle(context),
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s10),
                viewModel.getIsAccepted
                    ? SizedBox(
                  width: context.width() / 2,
                  child: ElevatedButton(
                    onPressed: viewModel.cancelAcceptTrip,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.error,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s10),
                      ),
                    ),
                    child: Text(
                      AppStrings.acceptingPassengersScreenButtonCancel.tr(),
                      style: AppTextStyles
                          .acceptingPassengersScreenButtonTextStyle(context),
                    ),
                  ),
                )
                    : const SizedBox(),
              ],
            ),
          );
        } else {
          return WaitingSearchingForPassengers();
        }
      },
    );
  }
}
