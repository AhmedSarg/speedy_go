import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:speedy_go/presentation/common/widget/main_trip_item.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/bus_page/pages/bus_trips_page/viewmodel/bus_trips_viewmodel.dart';
import 'package:speedy_go/presentation/resources/assets_manager.dart';
import 'package:speedy_go/presentation/resources/styles_manager.dart';

import '../../../../../../../../domain/models/domain.dart';
import '../../../../../../../resources/color_manager.dart';
import '../../../../../../../resources/font_manager.dart';
import '../../../../../../../resources/values_manager.dart';

class BusTripsBody extends StatelessWidget {
  const BusTripsBody({super.key});

  @override
  Widget build(BuildContext context) {
    BusTripsViewModel viewModel = BusTripsViewModel.get(context);
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          children: [
            SizedBox(
              height: AppSize.s100,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: (context.width() - AppSize.s62) * .2,
                            child: const Center(
                              child: CircleAvatar(
                                backgroundColor: ColorManager.lightGreen,
                                radius: AppSize.s8,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                viewModel.getPickup,
                                style: getSemiBoldStyle(
                                  fontSize: FontSize.f18,
                                  color: ColorManager.white,
                                ),
                              ),
                              const SizedBox(
                                width: AppSize.s10,
                              ),
                              Text(
                                DateFormat('MMM d, yyyy')
                                    .format(viewModel.getDepartureDate),
                                style: getSemiBoldStyle(
                                  fontSize: FontSize.f18,
                                  color: ColorManager.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: AppSize.s5,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: (context.width() - AppSize.s62) * .2,
                            child: const Center(
                              child: Icon(
                                Icons.arrow_drop_down,
                                size: AppSize.s40,
                              ),
                            ),
                          ),
                          Text(
                            viewModel.getDestination,
                            style: getSemiBoldStyle(
                              fontSize: FontSize.f18,
                              color: ColorManager.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    top: AppSize.s8 + AppSize.s5,
                    bottom: AppSize.s25 + AppSize.s4,
                    left: AppSize.s0,
                    child: SizedBox(
                      width: (context.width() - AppSize.s62) * .2,
                      child: Center(
                        child: Container(
                          color: ColorManager.black,
                          width: AppSize.s1,
                          height: AppSize.s26,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSize.s20),
            StreamBuilder<List<Future<TripBusModel>>>(
              stream: viewModel.getTripsStream,
              builder: (context, tripsSnapshot) {
                if (tripsSnapshot.hasData && tripsSnapshot.data!.isNotEmpty) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: tripsSnapshot.data!.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder(
                        future: tripsSnapshot.data![index],
                        builder: (context, tripFuture) {
                          if (tripFuture.hasData) {
                            TripBusModel trip = tripFuture.data!;
                            return GestureDetector(
                              onTap: () {
                                viewModel.onTapTrip(trip);
                              },
                              child: MainTripItem(
                                tripModel: trip,
                              ),
                            );
                          } else if (tripFuture.hasError) {
                            return Lottie.asset(LottieAssets.error,
                                repeat: false);
                          } else {
                            return Lottie.asset(
                              LottieAssets.loading,
                              width: context.width() * .2,
                              height: context.width() * .2
                            );
                          }
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: AppSize.s20);
                    },
                  );
                } else if (tripsSnapshot.hasData) {
                  return Lottie.asset(LottieAssets.empty);
                } else if (tripsSnapshot.hasError) {
                  return Lottie.asset(LottieAssets.error, repeat: false);
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(AppPadding.p50),
                    child: Lottie.asset(LottieAssets.loading),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
