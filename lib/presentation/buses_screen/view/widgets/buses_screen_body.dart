import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../pages/add_bus_screen/view/widgets/buses_item.dart';
import 'buses_logo_widget.dart';

class BusesScreenBody extends StatelessWidget {
  const BusesScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const BusesLogoWidget(),
          const SizedBox(
            height: AppSize.s18,
          ),
          Text(
            AppStrings.busesTitle.tr(),
            style: AppTextStyles.busesTitleTextStyle(context),
          ),
          BusesItem(
            textStyle: AppTextStyles.busesItemTextStyle(context),
            imageIcon: SVGAssets.schedule,
            title: AppStrings.busesschedule.tr(),
            backgroundColor: ColorManager.veryLightGrey,
            onTap: () {
              Navigator.pushNamed(context, Routes.scheduleRoute);
            },
            imageIconColor: ColorManager.lightShadeOfBlue.withOpacity(.75),
          ),
          BusesItem(
            textStyle: AppTextStyles.busesItemTextStyle(context),
            imageIconColor: ColorManager.lightShadeOfBlue.withOpacity(.75),
            imageIcon: SVGAssets.addBus_1,
            title: AppStrings.busesAddBus.tr(),
            backgroundColor: ColorManager.veryLightGrey,
            onTap: (){
              Navigator.pushNamed(context, Routes.addBusRoute);
            },
          ),
          BusesItem(
            textStyle: AppTextStyles.busesItemTextStyle(context),
            imageIconColor: ColorManager.lightShadeOfBlue.withOpacity(.75),
            imageIcon: SVGAssets.myBuses,
            title: AppStrings.busesMyBuses.tr(),
            backgroundColor: ColorManager.veryLightGrey,
            onTap: () {
              Navigator.pushNamed(context, Routes.myBusesRoute);
            },
          ),
          BusesItem(
            textStyle: AppTextStyles.busesItemTextStyle(context),
            imageIconColor: ColorManager.lightShadeOfBlue.withOpacity(.75),
            imageIcon: SVGAssets.addTrip,
            title: AppStrings.busesAddTrip.tr(),
            backgroundColor: ColorManager.veryLightGrey,
            onTap: () {
              Navigator.pushNamed(context, Routes.addBusTripRoute);
            },
          ),
        ],
      ),
    );
  }
}
