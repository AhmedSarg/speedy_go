import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:speedy_go/presentation/resources/assets_manager.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';
import 'package:speedy_go/presentation/resources/strings_manager.dart';
import 'package:speedy_go/presentation/resources/text_styles.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

class SearchMap extends StatelessWidget {
  const SearchMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p50),
              child: SvgPicture.asset(
                SVGAssets.logo,
                width: AppSize.s60,
                height: AppSize.s60,
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                height: AppSize.s100,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: AppSize.s1,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(AppSize.s20),
                    topLeft: Radius.circular(AppSize.s20),
                  ),
                  color: ColorManager.lightShadeOfGrey,
                ),
              ),
              Positioned(
                top: AppSize.s25 + AppSize.s4,
                bottom: AppSize.s25 + AppSize.s4,
                child: SizedBox(
                  width: (context.width() - AppSize.s40 - AppSize.s2) * .2,
                  child: Center(
                    child: Container(
                      color: ColorManager.black,
                      width: AppSize.s1,
                      height: AppSize.s42,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.s100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('frooom');
                      },
                      child: Container(
                        height: AppSize.s49,
                        child: Row(
                          children: [
                            SizedBox(
                              width:
                                  (context.width() - AppSize.s40 - AppSize.s2) *
                                      .2,
                              child: const Center(
                                child: CircleAvatar(
                                  backgroundColor: ColorManager.lightGreen,
                                  radius: AppSize.s4,
                                ),
                              ),
                            ),
                            Text(
                              "From : ",
                              style: AppTextStyles.tripMapScreenFromToTextStyle(
                                  context),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "choose using map ",
                                style: AppTextStyles
                                    .tripMapScreenPlaceholderTextStyle(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      color: ColorManager.mutedBlue,
                      height: AppSize.s2,
                    ),
                    SizedBox(
                      height: AppSize.s49,
                      child: Row(
                        children: [
                          SizedBox(
                            width:
                                (context.width() - AppSize.s40 - AppSize.s2) *
                                    .2,
                            child: const Center(
                              child: Icon(
                                Icons.arrow_drop_down,
                                size: AppSize.s40,
                              ),
                            ),
                          ),
                          Text(
                            "To : ",
                            style: AppTextStyles.tripMapScreenFromToTextStyle(
                                context),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(AppPadding.p10),
                              child: Text(
                                "choose using map ",
                                style: AppTextStyles
                                    .tripMapScreenPlaceholderTextStyle(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(color: ColorManager.mutedBlue),
              GestureDetector(
                onTap: () {},
                child: Text(
                  AppStrings.cancel,
                  style:
                      AppTextStyles.tripMapScreenFromToButtonTextStyle(context),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
