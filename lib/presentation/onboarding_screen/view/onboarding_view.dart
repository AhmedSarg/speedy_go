import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_styles.dart';
import '../../resources/values_manager.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            ImageAssets.loginBackgroundImage,
            height: AppSize.infinity,
            width: AppSize.infinity,
            fit: BoxFit.cover,
          ).animate().fade(
                duration: const Duration(milliseconds: 500),
                begin: AppSize.s0_5,
                end: AppSize.s1,
              ),
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: AppPadding.p100),
                  child: SizedBox.square(
                    dimension: AppSize.s150,
                    child: Hero(
                      tag: 'app-logo',
                      child: Transform.flip(
                        flipX: false,
                        child: SvgPicture.asset(SVGAssets.logo),
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 2),
                Text(
                  AppStrings.onBoardingScreenTitle.tr(),
                  style: AppTextStyles.onBoardingScreenTitleTextStyle(context),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p40),
                  child: SizedBox(
                    width: AppSize.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.loginRoute);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.black,
                        foregroundColor: ColorManager.white,
                        surfaceTintColor: ColorManager.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s10),
                        ),
                      ),
                      child: Text(
                        AppStrings.onBoardingScreenButton.tr(),
                        style: AppTextStyles.onBoardingScreenButtonTextStyle(
                            context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
