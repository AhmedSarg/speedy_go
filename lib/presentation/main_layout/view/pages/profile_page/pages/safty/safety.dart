import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:speedy_go/presentation/resources/assets_manager.dart';
import 'package:speedy_go/presentation/resources/font_manager.dart';
import 'package:speedy_go/presentation/resources/text_styles.dart';

import '../../../../../../resources/color_manager.dart';
import '../../../../../../resources/values_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class SafetyScreen extends StatelessWidget {
  const SafetyScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.CharredGrey,
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: AppSize.s50,
              ),
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
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              Center(
                child: CircleAvatar(
                  radius: AppSize.s60,
                  backgroundColor: ColorManager.cyan,
                  child: SvgPicture.asset(SVGAssets.safetyIcon),
                ),
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              Text(
                'Who do you want to contact ?',
                style: AppTextStyles.profileGeneralTextStyle(
                    context, FontSize.f20, ColorManager.offwhite ),
              ),
              const SizedBox(
                height: AppSize.s40,
              ),            Padding(
                padding: const EdgeInsets.only(left: AppPadding.p16),
                child: Row(
                  children: [
                    SvgPicture.asset(SVGAssets.callIcon),
                    const SizedBox(
                      width: AppSize.s16,
                    ),
                    Text(
                      'Police',
                      style: AppTextStyles.profileSmallTextStyle(
                          context, ColorManager.offwhite),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          _showModalBottomSheet(context,'123');

                        },
                        icon: const Icon(Icons.arrow_forward_ios,color: ColorManager.offwhite,size: AppSize.s20,))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p16),
                child: Row(
                  children: [
                    SvgPicture.asset(SVGAssets.callIcon),
                    const SizedBox(
                      width: AppSize.s16,
                    ),
                    Text(
                      'Ambulance',
                      style: AppTextStyles.profileSmallTextStyle(
                          context, ColorManager.offwhite),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          _showModalBottomSheet(context,'112');

                        },
                        icon: const Icon(Icons.arrow_forward_ios,color: ColorManager.offwhite,size: AppSize.s20,))
                  ],
                ),
              ),
          
            ],
          ),
        ),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context,String number) {
    showModalBottomSheet(
      backgroundColor: ColorManager.transparent,
      context: context,

      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(AppPadding.p16),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  launch('tel:+$number');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16,vertical: AppPadding.p12),
                  margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s16),
                      color: ColorManager.bgColor
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(SVGAssets.lightcallIcon),
                      const SizedBox(width: AppSize.s10,),
                      Text('Call $number',style: AppTextStyles.profileSmallTextStyle(context, ColorManager.lightBlue),),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16,vertical: AppPadding.p12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s16),
                      color: ColorManager.bgColor
                  ),
                  child: Center(child:                     Text('Cancel',style: AppTextStyles.profileSmallTextStyle(context, ColorManager.lightBlue),),
                  ),
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}


