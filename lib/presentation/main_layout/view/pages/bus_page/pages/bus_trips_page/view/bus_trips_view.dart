import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:speedy_go/presentation/base/cubit_builder.dart';
import 'package:speedy_go/presentation/base/cubit_listener.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/bus_page/pages/bus_trips_page/states/bus_trips_states.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/bus_page/pages/bus_trips_page/view/bus_trips_body.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/bus_page/pages/bus_trips_page/viewmodel/bus_trips_viewmodel.dart';
import 'package:speedy_go/presentation/resources/styles_manager.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

import '../../../../../../../../app/sl.dart';
import '../../../../../../../base/base_states.dart';
import '../../../../../../../resources/assets_manager.dart';
import '../../../../../../../resources/color_manager.dart';
import '../../../../../../../resources/font_manager.dart';
import '../../../../../../../resources/text_styles.dart';

class BusTripsPage extends StatelessWidget {
  const BusTripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.transparent,
        elevation: AppSize.s0,
        title: Text(
          'Available Buses',
          style: getSemiBoldStyle(
            color: ColorManager.white,
            fontSize: FontSize.f20,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          padding: const EdgeInsets.only(left: AppPadding.p8),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(AppSize.s0_5),
          child: Container(
            color: ColorManager.white,
            height: AppSize.s0_5,
          ),
        ),
      ),
      body: SizedBox(
        width: AppSize.infinity,
        height: AppSize.infinity,
        child: BlocProvider(
          create: (context) => BusTripsViewModel(sl())..start(),
          child: BlocConsumer<BusTripsViewModel, BaseStates>(
            listener: (context, state) {
              BusTripsViewModel viewModel = BusTripsViewModel.get(context);
              if (state is TripTappedState) {
                if (state.priceChange) {
                  Navigator.pop(context);
                }
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: ColorManager.lightBlack,
                      title: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Details',
                                style: AppTextStyles.profileGeneralTextStyle(
                                  context,
                                  FontSize.f20,
                                  ColorManager.lightBlue,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.close),
                              )
                            ],
                          ),
                          const Divider(
                            color: ColorManager.mutedBlue,
                          )
                        ],
                      ),
                      actionsOverflowButtonSpacing: 20,
                      actions: [
                        SizedBox(
                          height: AppSize.s100,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: (context.width() - AppSize.s62) *
                                            .2,
                                        child: const Center(
                                          child: CircleAvatar(
                                            backgroundColor:
                                                ColorManager.lightGreen,
                                            radius: AppSize.s8,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            state.trip.pickup,
                                            style: AppTextStyles
                                                .profileGeneralTextStyle(
                                                    context,
                                                    FontSize.f16,
                                                    ColorManager.lightBlue
                                                        .withOpacity(.8)),
                                          ),
                                          const SizedBox(
                                            width: AppSize.s10,
                                          ),
                                          Text(
                                            DateFormat('hh:mm a')
                                                .format(state.trip.date),
                                            style: AppTextStyles
                                                .profileGeneralTextStyle(
                                                    context,
                                                    FontSize.f12,
                                                    ColorManager.lightBlue
                                                        .withOpacity(.6)),
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
                                        width: (context.width() - AppSize.s62) *
                                            .2,
                                        child: const Center(
                                          child: Icon(
                                            Icons.arrow_drop_down,
                                            size: AppSize.s40,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        state.trip.destination,
                                        style: AppTextStyles
                                            .profileGeneralTextStyle(
                                          context,
                                          FontSize.f16,
                                          ColorManager.lightBlue
                                              .withOpacity(.8),
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
                        Row(
                          children: [
                            Text(
                              DateFormat('EEEE').format(state.trip.date),
                              style: AppTextStyles.profileGeneralTextStyle(
                                  context,
                                  FontSize.f18,
                                  ColorManager.lightBlue),
                            ),
                            const SizedBox(
                              width: AppSize.s16,
                            ),
                            Text(
                              DateFormat('MMM d, yyy').format(state.trip.date),
                              style: AppTextStyles.profileSmallTextStyle(
                                context,
                                ColorManager.lightBlue.withOpacity(.5),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'SpeedyGo Travel',
                              style: AppTextStyles.profileGeneralTextStyle(
                                  context,
                                  FontSize.f18,
                                  ColorManager.lightBlue),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Arrive at ',
                              style: AppTextStyles.profileGeneralTextStyle(
                                  context,
                                  FontSize.f18,
                                  ColorManager.lightBlue),
                            ),
                            Text(
                              '05:00 pm',
                              style: AppTextStyles.profileSmallTextStyle(
                                context,
                                ColorManager.lightBlue.withOpacity(.5),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(SVGAssets.seat),
                            const SizedBox(height: AppSize.s10),
                            IconButton(
                              onPressed: viewModel.getBookedSeats > 1
                                  ? viewModel.removeSeat
                                  : null,
                              icon: const Icon(Icons.remove),
                            ),
                            const SizedBox(height: AppSize.s5),
                            Text(
                              viewModel.getBookedSeats.toString(),
                              style: AppTextStyles.profileSmallTextStyle(
                                context,
                                ColorManager.lightBlue.withOpacity(.5),
                              ),
                            ),
                            const SizedBox(height: AppSize.s5),
                            IconButton(
                              onPressed: state.trip.availableSeats! >
                                      viewModel.getBookedSeats
                                  ? viewModel.addSeat
                                  : null,
                              icon: const Icon(Icons.add),
                            ),
                            Text(
                              'Seats',
                              style: AppTextStyles.profileSmallTextStyle(
                                context,
                                ColorManager.lightBlue.withOpacity(.5),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Price ${state.trip.price * viewModel.getBookedSeats}.0 EGP',
                            style: AppTextStyles.profileGeneralTextStyle(
                              context,
                              FontSize.f18,
                              ColorManager.lightBlue,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: context.width() * .5,
                            child: ElevatedButton(
                              onPressed: viewModel.bookBusTrip,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorManager.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s15),
                                  )),
                              child: Text(
                                'Book now',
                                style: getRegularStyle(
                                  color: ColorManager.white,
                                  fontSize: FontSize.f14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
              else if (state is SuccessState) {
                Navigator.pop(context);
              }
              baseListener(context, state);
            },
            builder: (context, state) {
              return baseBuilder(context, state, BusTripsBody());
            },
          ),
        ),
      ),
    );
  }
}
