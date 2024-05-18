import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:speedy_go/domain/models/domain.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/profile_page/pages/request_history/viewmodel/request_history_viewmodel.dart';
import 'package:speedy_go/presentation/resources/assets_manager.dart';
import 'package:speedy_go/presentation/resources/font_manager.dart';

import '../../../../../../../resources/color_manager.dart';
import '../../../../../../../resources/text_styles.dart';
import '../../../../../../../resources/values_manager.dart';

class RequestHistoryBody extends StatelessWidget {
  const RequestHistoryBody({super.key});

  static late RequestHistoryViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = RequestHistoryViewModel.get(context);
    return ListView.separated(
      padding: const EdgeInsets.all(AppPadding.p20),
      physics: const BouncingScrollPhysics(),
      itemCount: viewModel.getHistoryTrips.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            FutureBuilder(
              future: viewModel.getHistoryTrips[index],
              builder: (context, futureTrip) {
                if (futureTrip.hasData) {
                  HistoryTripModel trip = futureTrip.data!;
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${DateFormat('d MMMM').format(trip.date)} at ${DateFormat('hh:mm a').format(trip.date)}',
                          style: AppTextStyles.profileGeneralTextStyle(
                            context,
                            FontSize.f14,
                            ColorManager.offwhite,
                          ),
                        ),
                        Text(
                          trip.pickupAddress,
                          style: AppTextStyles.requestTextStyle(
                            context,
                          ),
                        ),
                        Text(
                          trip.destinationAddress,
                          style: AppTextStyles.requestTextStyle(
                            context,
                          ),
                        ),
                        Text(
                          'EGP ${trip.price}',
                          style: AppTextStyles.profileGeneralTextStyle(
                              context, FontSize.f18, ColorManager.offwhite),
                        ),
                      ],
                    ),
                  );
                } else if (futureTrip.hasError) {
                  return SizedBox(
                    height: AppSize.s100,
                    child: Lottie.asset(LottieAssets.error, repeat: false),
                  );
                } else {
                  return SizedBox(
                    height: AppSize.s100,
                    child: Center(
                      child: Lottie.asset(
                        LottieAssets.loading,
                        width: context.width() * .2,
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: AppSize.s20),
            Divider(
              color: ColorManager.offwhite_2,
              height: AppSize.s0_5,
              thickness: AppSize.s0_5,
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: AppSize.s20);
      },
    );
  }
}
