import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';

class SplashScreenDriverBody extends StatefulWidget {
  const SplashScreenDriverBody({super.key});

  @override
  State<SplashScreenDriverBody> createState() => _SplashScreenDriverBodyState();
}

class _SplashScreenDriverBodyState extends State<SplashScreenDriverBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.onboardingRoute);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssets.driverimage),
            fit: BoxFit.cover,
          ),
        ),


      child: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget? child) {
            return Transform.scale(
              scale: _animation.value,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text(AppStrings.splashScreenTitleDriver.tr(),style: AppTextStyles.SplashScreenTitleTextStyle(context),)),
                  Center(child: Text(AppStrings.splashSubScreenTitle.tr(),style: AppTextStyles.SplashScreenSubTitleTextStyle(context))),

                ],
              ),
            );
          },
        ),
      ),
    );
  }
}