import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../resources/assets_manager.dart';
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
            fit: BoxFit.cover,
          ).animate().fade(
                duration: const Duration(milliseconds: 600),
                begin: AppSize.s0_5,
                end: AppSize.s1,
              ),
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: AppSize.s100),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
