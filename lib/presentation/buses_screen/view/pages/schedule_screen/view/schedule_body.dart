import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:speedy_go/presentation/resources/font_manager.dart';

import '../../../../../../domain/models/domain.dart';
import '../../../../../resources/assets_manager.dart';
import '../../../../../resources/color_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/text_styles.dart';
import '../../../../../resources/values_manager.dart';
import '../../../widgets/buses_logo_widget.dart';
import '../../add_bus_screen/view/widgets/buses_item.dart';
import '../viewmodel/schedule_viewmodel.dart';

class SehedualBodyScreen extends StatelessWidget {
  const SehedualBodyScreen({super.key, required this.viewModel});

  final ScheduleViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * .10),
        const BusesLogoWidget(),
        BusesItem(
          textStyle: AppTextStyles.busesSubItemTextStyle(context),
          imageIconColor: ColorManager.white.withOpacity(.8),
          imageIcon: SVGAssets.schedule,
          title: AppStrings.busesschedule.tr(),
          backgroundColor: ColorManager.lightBlue,
        ),
        const SizedBox(height: AppSize.s18),
        FittedBox(
          child: Row(
            children: [
              const SizedBox(
                width: AppSize.s30,
              ),
              const SizedBox(
                width: AppSize.s40,
              ),
              InkWell(
                onTap: () {
                  showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    initialDate: DateTime.now(),
                    currentDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          datePickerTheme: DatePickerThemeData(
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSize.s16),
                            ),
                          ),
                          colorScheme: const ColorScheme.light().copyWith(
                            primary: ColorManager.lightBlue,
                            onPrimary: Colors.white,
                            surface: ColorManager.white,
                            onSurface: ColorManager.black,
                          ),
                          dialogBackgroundColor: Colors.white,
                        ),
                        child: child!,
                      );
                    },
                  ).then((selectedDate) {
                    if (selectedDate != null) {
                      viewModel.setDate = selectedDate;
                    }
                  });
                },
                child: CircleAvatar(
                    backgroundColor: ColorManager.lightBlue,
                    radius: AppSize.s20,
                    child: SvgPicture.asset(SVGAssets.calender)),
              ),
              const SizedBox(
                width: AppSize.s30,
              ),
            ],
          ),
        ),
        SizedBox(
          height: AppSize.s300,
          child: StreamBuilder<List<BusModel>>(
            stream: viewModel.getBusesStream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data?[index];

                    return Container(
                      width: MediaQuery.of(context).size.width * .7,
                      margin: const EdgeInsets.symmetric(
                          horizontal: AppSize.s12, vertical: AppSize.s10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSize.s12, vertical: AppSize.s10),
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorManager.lightBlack),
                          borderRadius: BorderRadius.circular(AppSize.s10),
                          color: ColorManager.offwhite),
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
                                  style: AppTextStyles.profileGeneralTextStyle(
                                      context, FontSize.f17, ColorManager.blue),
                                ),
                                Text(
                                  item!.licensePlate,
                                  style: AppTextStyles.profileGeneralTextStyle(
                                      context, FontSize.f12, ColorManager.grey),
                                ),
                                RichText(
                                    text: TextSpan(
                                        text: "Seats number : ",
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
                                      )
                                    ]))
                              ],
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
              } else if (snapshot.data!.isEmpty) {
                return Lottie.asset(LottieAssets.success);
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
        ),
      ],
    );
  }
}
