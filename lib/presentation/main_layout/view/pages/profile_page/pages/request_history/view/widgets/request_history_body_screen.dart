import 'package:flutter/material.dart';
import 'package:speedy_go/presentation/resources/font_manager.dart';

import '../../../../../../../../resources/color_manager.dart';
import '../../../../../../../../resources/text_styles.dart';
import '../../../../../../../../resources/values_manager.dart';

class RequestHistoryBodyScreen extends StatelessWidget {
  const RequestHistoryBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.darkGrey,

      body:        Column(
        children: [
          const SizedBox(height: AppSize.s40,),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(
                      padding: const EdgeInsets.all(AppPadding.p10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorManager.black,
                              width: AppSize.s1_2),
                          shape: BoxShape.circle,
                          color: ColorManager.black.withOpacity(.4)),
                      child: const Icon(
                        Icons.arrow_back,
                        color: ColorManager.white,
                      ))),
              const Spacer(),

              Text(
                'request history ',
                style: AppTextStyles.profileGeneralTextStyle(
                    context, FontSize.f20, ColorManager.offwhite),
              ) ,
              const Spacer(),
              const SizedBox(width: AppSize.s40,)
            ],
          ),
           Divider(
            color: ColorManager.offwhite_2,
            height: AppSize.s0_5,
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                    margin: const EdgeInsets.symmetric(vertical: AppMargin.m10),

                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text('28 March at 09:00',style: AppTextStyles.profileGeneralTextStyle(context, FontSize.f14, ColorManager.offwhite)),
                        Text('Canceled',style: AppTextStyles.profileGeneralTextStyle(context, FontSize.f14, ColorManager.red)),

                      ],),
                      Row(children: [
                        Text('Haret Dakhli Raqam 33 7',style: AppTextStyles.requestTextStyle(context, )),

                      ],),
                      Row(children: [
                        Text('Street 16 172 Villa Alshahed',style: AppTextStyles.requestTextStyle(context, )),

                      ],),
                      Row(children: [
                        Text('EGP 90',style: AppTextStyles.profileGeneralTextStyle(context, FontSize.f18, ColorManager.offwhite),),

                      ],),
                    ],
                  )
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return  Divider(
                  color: ColorManager.offwhite_2,
                  height: AppSize.s0_5,
                );
              },
              itemCount: 3,
            ),
          ),
        ],
      ),

    );
  }
}
