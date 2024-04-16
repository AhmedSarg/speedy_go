import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../../resources/assets_manager.dart';
import '../../../../../../../../resources/color_manager.dart';
import '../../../../../../../../resources/font_manager.dart';
import '../../../../../../../../resources/text_styles.dart';
import '../../../../../../../../resources/values_manager.dart';

class CurrentTripItem extends StatelessWidget {
  const CurrentTripItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor:  ColorManager.offwhite,
              contentPadding: const EdgeInsets.all(AppPadding.p0),
              content: Container(

                height: MediaQuery.of(context).size.height*.6,
                width: MediaQuery.of(context).size.width*.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s16)
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:  const EdgeInsets.only(top: AppPadding.p16,left: AppPadding.p18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Details',style: AppTextStyles.profileGeneralTextStyle(context, FontSize.f20,ColorManager.lightBlue),),
                          IconButton(onPressed: () {
                            Navigator.pop(context);
                          }, icon: Icon(Icons.close))
                        ],
                      ),
                    ),
                    const Divider(color: ColorManager.lightGrey,height: AppSize.s0_5,),

                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: AppPadding.p16, vertical: AppPadding.p12),
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p16, vertical: AppPadding.p12),
        height: AppSize.s110,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s12),
            color: ColorManager.veryLightGrey),
        child: ListTile(
          leading: SvgPicture.asset(SVGAssets.redBus),
          title: Text(
            '02:00 pm',
            style: AppTextStyles.profileGeneralTextStyle(
                context, FontSize.f16, ColorManager.lightBlue),
          ),
          subtitle: Text(
            '12 seats available',
            style: AppTextStyles.profileHintTextStyle(context),
          ),
          trailing: Text(
            ' 130.0 EGP',
            style: AppTextStyles.profileGeneralTextStyle(
                context, FontSize.f17, ColorManager.lightBlue),
          ),
        ),
      ),
    );
  }
}
