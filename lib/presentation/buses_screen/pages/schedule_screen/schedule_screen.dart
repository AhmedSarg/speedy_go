import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_go/presentation/buses_screen/view/widgets/buses_item.dart';
import 'package:speedy_go/presentation/buses_screen/view/widgets/buses_logo_widget.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: Column(
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
          Row(
            children: [
              const Spacer(),
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
                width: AppSize.s10,
              ),
            ],
          )
        ],
      ),
    );
  }
}
