import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:speedy_go/presentation/resources/styles_manager.dart';

import '../../../../../../domain/models/domain.dart';
import '../../../../../common/widget/main_button.dart';
import '../../../../../resources/assets_manager.dart';
import '../../../../../resources/color_manager.dart';
import '../../../../../resources/font_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/text_styles.dart';
import '../../../../../resources/values_manager.dart';
import '../../../widgets/buses_logo_widget.dart';
import '../../add_bus_screen/view/widgets/buses_item.dart';
import '../viewmodel/my_buses_viewmodel.dart';

class MyBusesBody extends StatelessWidget {
  const MyBusesBody({super.key, required this.viewModel});

  final MyBusesViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: AppSize.s49,
          ),
          const BusesLogoWidget(),
          Center(
            child: BusesItem(
              textStyle: AppTextStyles.busesSubItemTextStyle(context),
              imageIconColor: ColorManager.white.withOpacity(.8),
              imageIcon: SVGAssets.addTrip,
              title: AppStrings.busesMyBuses.tr(),
              backgroundColor: ColorManager.lightBlue,
            ),
          ),
          StreamBuilder<List<BusModel>>(
            stream: viewModel.getBusesStream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data?[index];
                    return Container(
                      width: MediaQuery.of(context).size.width * .7,
                      margin: const EdgeInsets.symmetric(
                          horizontal: AppSize.s12, vertical: AppSize.s10),
                      padding: const EdgeInsets.all(AppPadding.p5),
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorManager.lightBlack),
                          borderRadius: BorderRadius.circular(AppSize.s10),
                          color: ColorManager.offwhite),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(AppPadding.p8),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    SvgPicture.asset(
                                      SVGAssets.blueBus,
                                      color: ColorManager.blue,
                                    )
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        'bus',
                                        style: AppTextStyles
                                            .profileGeneralTextStyle(
                                                context,
                                                FontSize.f17,
                                                ColorManager.blue),
                                      ),
                                      Text(
                                        item!.licensePlate,
                                        style: AppTextStyles
                                            .profileGeneralTextStyle(
                                                context,
                                                FontSize.f12,
                                                ColorManager.grey),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: "Seats Number: ",
                                          style: AppTextStyles.busItemTextStyle(
                                            context,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: '${item.seats} Seat',
                                              style: AppTextStyles
                                                  .profileGeneralTextStyle(
                                                      context,
                                                      FontSize.f12,
                                                      ColorManager.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Transform.rotate(
                            angle: pi * -.1,
                            child: Text(
                              '#${item.busNumber}',
                              style: getBoldStyle(
                                color: ColorManager.secondary,
                                fontSize: FontSize.f22,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: AppSize.s10,
                    );
                  },
                );
              } else if (snapshot.hasData) {
                return Lottie.asset(LottieAssets.empty);
              } else if (snapshot.hasError) {
                return Lottie.asset(LottieAssets.error);
              } else {
                return Padding(
                  padding: const EdgeInsets.all(AppPadding.p50),
                  child: Lottie.asset(LottieAssets.loading),
                );
              }
            },
          ),
          const SizedBox(
            height: AppSize.s30,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .5,
            child: SecondButton(
              bgcolor: ColorManager.offwhite,
              onPressed: () {
                Navigator.pop(context);
              },
              text: 'Back',
              textStyle: AppTextStyles.busesItemTextStyle(context),
            ),
          )
        ],
      ),
    );
  }
}
