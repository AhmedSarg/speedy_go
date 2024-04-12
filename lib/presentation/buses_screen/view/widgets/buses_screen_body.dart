import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/presentation/buses_screen/view/widgets/buses_item.dart';
import 'package:speedy_go/presentation/buses_screen/view/widgets/buses_logo_widget.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';
import 'package:speedy_go/presentation/resources/routes_manager.dart';
import 'package:speedy_go/presentation/resources/strings_manager.dart';
import 'package:speedy_go/presentation/resources/strings_manager.dart';
import 'package:speedy_go/presentation/resources/strings_manager.dart';
import 'package:speedy_go/presentation/resources/strings_manager.dart';
import 'package:speedy_go/presentation/resources/text_styles.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

import '../../../resources/assets_manager.dart';

class BusesScreenBody extends StatelessWidget {
  const BusesScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const BusesLogonWidget(),
          const SizedBox(height: AppSize.s18,),
          Text(AppStrings.busesTitle.tr(),style: AppTextStyles.busesTitleTextStyle(context),),
           BusesItem(textStyle: AppTextStyles.busesItemTextStyle(context),imageIcon: SVGAssets.schedule, title:AppStrings.busesschedule.tr(), backgroundColor: ColorManager.lightShadeOfGrey,onTap: () {
             Navigator.pushNamed(context, Routes.scheduleRoute);
           }, imageIconColor:       ColorManager.lightShadeOfblue.withOpacity(.75),),
         BusesItem(textStyle: AppTextStyles.busesItemTextStyle(context), imageIconColor: ColorManager.lightShadeOfblue.withOpacity(.75),imageIcon: SVGAssets.addBus_1, title:  AppStrings.busesAddBus.tr(), backgroundColor:  ColorManager.lightShadeOfGrey,),
         BusesItem (textStyle: AppTextStyles.busesItemTextStyle(context),imageIconColor: ColorManager.lightShadeOfblue.withOpacity(.75),imageIcon: SVGAssets.myBuses,  title:  AppStrings.busesMyBuses.tr(), backgroundColor: ColorManager.lightShadeOfGrey,),
          BusesItem(textStyle: AppTextStyles.busesItemTextStyle(context),imageIconColor: ColorManager.lightShadeOfblue.withOpacity(.75),imageIcon: SVGAssets.addTrip,  title:  AppStrings.busesAddTrip.tr(), backgroundColor: ColorManager.lightShadeOfGrey,),
        ],
      ),
    );
  }
}
