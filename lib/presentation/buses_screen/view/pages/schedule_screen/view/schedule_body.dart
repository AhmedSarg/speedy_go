import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:speedy_go/presentation/resources/font_manager.dart';

import '../../../../../../domain/models/domain.dart';
import '../../../../../resources/assets_manager.dart';
import '../../../../../resources/color_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/styles_manager.dart';
import '../../../../../resources/text_styles.dart';
import '../../../../../resources/values_manager.dart';
import '../../../widgets/buses_logo_widget.dart';
import '../../add_bus_screen/view/widgets/buses_item.dart';
import '../viewmodel/schedule_viewmodel.dart';

class ScheduleBodyScreen extends StatelessWidget {
  const ScheduleBodyScreen({super.key, required this.viewModel});

  final ScheduleViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                const SizedBox(width: AppSize.s30),
                InkWell(
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      initialDate: viewModel.getSelectedDate,
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            datePickerTheme: DatePickerThemeData(
                              shape: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s16),
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
                    );
                    if (selectedDate != null) {
                      viewModel.setDate = selectedDate;
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: ColorManager.lightBlue,
                    radius: AppSize.s20,
                    child: SvgPicture.asset(SVGAssets.calender),
                  ),
                ),
                const SizedBox(width: AppSize.s30),
              ],
            ),
          ),
          StreamBuilder<List<Future<TripBusModel>>>(
            stream: viewModel.getBusesStream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final futureTrip = snapshot.data?[index];
                    return FutureBuilder<TripBusModel>(
                      future: futureTrip,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          TripBusModel item = snapshot.data!;
                          return Container(
                            width: MediaQuery.of(context).size.width * .7,
                            margin: const EdgeInsets.symmetric(
                                horizontal: AppSize.s12, vertical: AppSize.s10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppSize.s12, vertical: AppSize.s10),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: ColorManager.lightBlack),
                              borderRadius: BorderRadius.circular(AppSize.s10),
                              color: ColorManager.offwhite,
                            ),
                            child: Stack(

                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        SvgPicture.asset(
                                          SVGAssets.blueBus,
                                          color: ColorManager.blue,
                                        ),
                                        Text(
                                          'Bus',
                                          style: AppTextStyles
                                              .profileGeneralTextStyle(
                                              context,
                                              FontSize.f12,
                                              ColorManager.blue),
                                        ),

                                        Text(item.busModel.licensePlate)
                                      ],
                                    ),
                                    const SizedBox(width: AppSize.s12),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Row(
                                          children: [
                                            Text(
                                              'Form : ',
                                              style: AppTextStyles
                                                  .profileGeneralTextStyle(
                                                  context,
                                                  FontSize.f18,
                                                  ColorManager.blue),
                                            ),
                                            Text(
                                              item.pickup,
                                              style: AppTextStyles
                                                  .profileGeneralTextStyle(
                                                  context,
                                                  FontSize.f14,
                                                  ColorManager.grey),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'To : ',
                                              style: AppTextStyles
                                                  .profileGeneralTextStyle(
                                                  context,
                                                  FontSize.f18,
                                                  ColorManager.blue),
                                            ),
                                            Text(
                                              item.destination,
                                              style: AppTextStyles
                                                  .profileGeneralTextStyle(
                                                  context,
                                                  FontSize.f14,
                                                  ColorManager.grey),
                                            ),

                                          ],
                                        ),

                                      ],
                                    ),
                                    const SizedBox(width: AppSize.s12),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Row(
                                          children: [
                                            Text(
                                              'Price : ',
                                              style: AppTextStyles
                                                  .profileGeneralTextStyle(
                                                  context,
                                                  FontSize.f18,
                                                  ColorManager.blue),
                                            ),
                                            Text(
                                              '${item.price}',
                                              style: AppTextStyles
                                                  .profileGeneralTextStyle(
                                                  context,
                                                  FontSize.f14,
                                                  ColorManager.grey),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [

                                            Text(
                                              _formatDate('${item.date}'),

                                              style: AppTextStyles
                                                  .profileGeneralTextStyle(
                                                  context,
                                                  FontSize.f14,
                                                  ColorManager.grey),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),

                                  ],
                                ),
                                Transform.rotate(
                                  angle: pi * -.1,
                                  child: Text(
                                    '#${item.busModel.busNumber}',
                                    style: getBoldStyle(
                                      color: ColorManager.secondary,
                                      fontSize: FontSize.f22,
                                    ),
                                  ),
                                )

                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Lottie.asset(
                              LottieAssets.error,
                              repeat: false,
                            ),
                          );
                        } else {
                          return Center(
                            child: Lottie.asset(
                              LottieAssets.loading,
                              width: context.width() * .3,
                            ),
                          );
                        }
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: AppSize.s10);
                  },
                );
              } else if (snapshot.hasData) {
                return Lottie.asset(LottieAssets.empty);
              } else if (snapshot.hasError) {
                return Lottie.asset(LottieAssets.error, repeat: false);
              } else {
                return Padding(
                  padding: const EdgeInsets.all(AppPadding.p100),
                  child: Lottie.asset(LottieAssets.loading),
                );
              }
            },
          ),
        ],
      ),
    );
  }
  String _formatDate(String dateString) {
    final DateTime date = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('yyyy-MM-dd h:mm a');
    return formatter.format(date);
  }
}
