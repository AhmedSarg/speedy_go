import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/app/extensions.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/text_styles.dart';
import '../../resources/values_manager.dart';

class MainTripItem extends StatelessWidget {
  const MainTripItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: ColorManager.lightBlack,
              contentPadding: const EdgeInsets.all(AppPadding.p0),
              title: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p12, top: AppPadding.p16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Details',
                          style: AppTextStyles.profileGeneralTextStyle(
                              context, FontSize.f20, ColorManager.lightBlue),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close))
                      ],
                    ),
                  ),
                  const Divider(
                    color: ColorManager.mutedBlue,
                  )
                ],
              ),
              actionsOverflowButtonSpacing: 20,
              actions: [
                SizedBox(
                  height: AppSize.s100,
                  child: Stack(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: (context.width() - AppSize.s62) * .2,
                                child: const Center(
                                  child: CircleAvatar(
                                    backgroundColor: ColorManager.lightGreen,
                                    radius: AppSize.s8,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Cairo',
                                    style:
                                        AppTextStyles.profileGeneralTextStyle(
                                            context,
                                            FontSize.f16,
                                            ColorManager.lightBlue
                                                .withOpacity(.8)),
                                  ),
                                  const SizedBox(
                                    width: AppSize.s10,
                                  ),
                                  Text(
                                    '02:00 pm',
                                    style:
                                        AppTextStyles.profileGeneralTextStyle(
                                            context,
                                            FontSize.f12,
                                            ColorManager.lightBlue
                                                .withOpacity(.6)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: AppSize.s5,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: (context.width() - AppSize.s62) * .2,
                                child: const Center(
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    size: AppSize.s40,
                                  ),
                                ),
                              ),
                              Text('Ismailia',
                                  style: AppTextStyles.profileGeneralTextStyle(
                                      context,
                                      FontSize.f16,
                                      ColorManager.lightBlue.withOpacity(.8))),
                            ],
                          ),
                        ],
                      ),
                      Positioned(
                        top: AppSize.s8 + AppSize.s5,
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
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Spacer(),
                    Text(
                      'Thursday',
                      style: AppTextStyles.profileGeneralTextStyle(
                          context, FontSize.f18, ColorManager.lightBlue),
                    ),
                    const SizedBox(
                      width: AppSize.s16,
                    ),
                    Text(
                      'May 18, 2024',
                      style: AppTextStyles.profileSmallTextStyle(
                        context,
                        ColorManager.lightBlue.withOpacity(.5),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'SpeedyGo Travel',
                      style: AppTextStyles.profileGeneralTextStyle(
                          context, FontSize.f18, ColorManager.lightBlue),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Arrive at ',
                      style: AppTextStyles.profileGeneralTextStyle(
                          context, FontSize.f18, ColorManager.lightBlue),
                    ),
                    Text(
                      '05:00 pm',
                      style: AppTextStyles.profileSmallTextStyle(
                        context,
                        ColorManager.lightBlue.withOpacity(.5),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price 125.0 EGP',
                      style: AppTextStyles.profileGeneralTextStyle(
                          context, FontSize.f18, ColorManager.lightBlue),
                    ),
                    const Spacer(),
                    SvgPicture.asset(SVGAssets.seat),
                    Row(
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.add,
                                size: AppSize.s15,
                              ),
                            ),
                            Text(
                              "1",
                              style: AppTextStyles.profileSmallTextStyle(
                                context,
                                ColorManager.lightBlue.withOpacity(.5),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.remove,
                                size: AppSize.s15,
                              ),
                            )
                          ],
                        ),
                        Text(
                          'seat',
                          style: AppTextStyles.profileSmallTextStyle(
                            context,
                            ColorManager.lightBlue.withOpacity(.5),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // const Spacer(),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width*.7,
                //   child: MainButton(bgColor: ColorManager.green,text: 'Book', onPressed: () {
                //     Navigator.pop(context);
                //   },),
                // ),
                const SizedBox(
                  height: AppSize.s20,
                ),
              ],
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
          color: ColorManager.veryLightGrey,
        ),
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
