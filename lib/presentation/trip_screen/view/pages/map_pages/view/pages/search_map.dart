import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_go/presentation/resources/assets_manager.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';
import 'package:speedy_go/presentation/resources/strings_manager.dart';
import 'package:speedy_go/presentation/resources/text_styles.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

class SearchMap extends StatelessWidget {
  const SearchMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.black,
      body: Column(
        children: [
          Align(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p50),
              child: SvgPicture.asset(
                SVGAssets.logo,
                width: AppSize.s60,
                height: AppSize.s60,
              ),
            ),
            alignment: Alignment.topLeft,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(AppSize.s20), topLeft: Radius.circular(AppSize.s20)),
              color: ColorManager.lightShadeOfGrey,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(AppPadding.p14),
                      child: CircleAvatar(
                        backgroundColor: ColorManager.lightGreen,
                        radius: 7,
                      ),
                    ),
                    Text("From : ",style: AppTextStyles.searchMapScreenTextStyle(context),),
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(AppPadding.p10),
                        child: Text("choose using map ",style: AppTextStyles.searchMapScreenChooseTextStyle(context),),
                      ),
                    ),
                  ],
                ),
                const Divider(color: ColorManager.mutedBlue),
                Row(
                  children: [
                    Icon(Icons.arrow_drop_down, size: AppSize.s40),
                    Text("To : ",style: AppTextStyles.searchMapScreenTextStyle(context),),
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(AppPadding.p10),
                        child: Text("choose using map ",style: AppTextStyles.searchMapScreenChooseTextStyle(context),),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(color: ColorManager.mutedBlue),
              GestureDetector(onTap: (){}, child: Text(AppStrings.cancel,style: AppTextStyles.searchMapScreenButtonTextStyle(context),))
            ],
          )
        ],
      ),
    );
  }
}
