import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/bus_page/pages/bus_trips_page/viewmodel/bus_trips_viewmodel.dart';
import 'package:speedy_go/presentation/resources/styles_manager.dart';
import 'package:speedy_go/presentation/resources/styles_manager.dart';
import 'package:speedy_go/presentation/resources/styles_manager.dart';

import '../../../../../../../resources/color_manager.dart';
import '../../../../../../../resources/font_manager.dart';
import '../../../../../../../resources/text_styles.dart';
import '../../../../../../../resources/values_manager.dart';

class BusTripsBody extends StatelessWidget {
  const BusTripsBody({super.key});

  @override
  Widget build(BuildContext context) {
    BusTripsViewModel viewModel = BusTripsViewModel.get(context);
    return SafeArea(
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
        ],
      ),
    );
  }
}
