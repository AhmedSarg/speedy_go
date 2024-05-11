import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/presentation/resources/font_manager.dart';

import '../../../../../resources/assets_manager.dart';
import '../../../../../resources/color_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/text_styles.dart';
import '../../../../../resources/values_manager.dart';
import '../../../../view/widgets/buses_logo_widget.dart';
import '../../../add_bus_screen/view/widgets/buses_item.dart';

class SehedualBodyScreen extends StatefulWidget {
  const SehedualBodyScreen({super.key});

  @override
  State<SehedualBodyScreen> createState() => _SehedualBodyScreenState();
}

class _SehedualBodyScreenState extends State<SehedualBodyScreen> {
  DateTime _selectedDate = DateTime.now();

  Widget _buildCalendar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              setState(() {
                print('_____________1');
                print(_selectedDate);
                _selectedDate = _selectedDate.subtract(Duration(days: 1));
                print('_____________2');
                print(_selectedDate);
              });
            },
            icon: const Icon(Icons.arrow_back_ios)
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: EasyDateTimeLine(
            activeColor: ColorManager.lightBlue,
            initialDate: _selectedDate,
            onDateChange: (selectedDate) {
              setState(() {
                _selectedDate = selectedDate;
              });
            },
            itemBuilder: (context, dayNumber, dayName, monthName, fullDate, isSelected) {
              return Container(
                width: AppSize.s60,
                margin: const EdgeInsets.symmetric(horizontal: AppMargin.m4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s16),
                  color: isSelected ? ColorManager.lightBlue : ColorManager.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dayNumber.toString(),
                      style: isSelected
                          ? AppTextStyles.busesGeneralTextStyle(context, ColorManager.offwhite, FontSize.f20)
                          : AppTextStyles.busesGeneralTextStyle(context, ColorManager.lightBlack, FontSize.f14),
                    ),
                    Text(
                      dayName.toString(),
                      style: isSelected
                          ? AppTextStyles.busesGeneralTextStyle(context, ColorManager.offwhite, FontSize.f18)
                          : AppTextStyles.busesGeneralTextStyle(context, ColorManager.lightBlack, FontSize.f12),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        IconButton(
            onPressed: () {
              setState(() {
                _selectedDate = _selectedDate.add(Duration(days: 1));
              });
            },
            icon: const Icon(Icons.arrow_forward_ios)
        ),
      ],
    );
  }

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
          
              _buildCalendar(),
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
                      print('Selected date: $selectedDate');
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



      ],
    );
  }
}
