import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/app/extensions.dart';

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
                    const Divider(
                      color: ColorManager.mutedBlue,
                      height: AppSize.s0_5,
                    ),
                    Container(
                      height: AppSize.s100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: AppSize.s100,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width:
                                              (context.width() - AppSize.s62) *
                                                  .2,
                                          child: const Center(
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  ColorManager.lightGreen,
                                              radius: AppSize.s4,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: Row(
                                          children: [
                                            Text(
                                              'Cairo',
                                              style: AppTextStyles
                                                  .profileGeneralTextStyle(
                                                      context,
                                                      FontSize.f16,
                                                      ColorManager.lightBlue
                                                          .withOpacity(.8)),
                                            ),
                                            SizedBox(
                                              width: AppSize.s10,
                                            ),
                                            Text(
                                              '02:00 pm',
                                              style: AppTextStyles
                                                  .profileGeneralTextStyle(
                                                      context,
                                                      FontSize.f12,
                                                      ColorManager.lightBlue
                                                          .withOpacity(.6)),
                                            ),
                                          ],
                                        )),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width:
                                          (context.width() - AppSize.s62) *
                                              .2,
                                          child: const Center(
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              size: AppSize.s40,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: Text('Ismailia',
                                                style: AppTextStyles
                                                    .profileGeneralTextStyle(
                                                    context,
                                                    FontSize.f16,
                                                    ColorManager.lightBlue
                                                        .withOpacity(.8)))),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                              Positioned(
                                top: AppSize.s8 + AppSize.s4,
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
                          const SizedBox(height: AppSize.s10,),
                          Row(
                            children: [
                              Text('Thursday',
                                  style: AppTextStyles
                                      .profileGeneralTextStyle(
                                      context,
                                      FontSize.f20,
                                      ColorManager.lightBlue
                                  )),
                              Text('May 18, 2024',
                                  style: AppTextStyles
                                      .profileGeneralTextStyle(
                                      context,
                                      FontSize.f16,
                                      ColorManager.lightBlue
                                          .withOpacity(.8))),
                            ],
                          ),
                        ],
                      ),
                    ),
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
