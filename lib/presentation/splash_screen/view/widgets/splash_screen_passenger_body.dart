import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';

class SplashScreenPassengerBody extends StatefulWidget {
  const SplashScreenPassengerBody({super.key});

  @override
  State<SplashScreenPassengerBody> createState() => _SplashScreenPassengerBodyState();
}

class _SplashScreenPassengerBodyState extends State<SplashScreenPassengerBody>
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
      Navigator.pushReplacementNamed(context, Routes.selectionRoute);
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
          image: AssetImage(ImageAssets.passengerSelectionTileImage),
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
                  Center(child: Text(AppStrings.splashScreenPassengerTitle.tr(),style: AppTextStyles.splashScreenTitleTextStyle(context),)),
                  Center(child: Text(AppStrings.splashScreenSubTitle.tr(),style: AppTextStyles.splashScreenSubTitleTextStyle(context))),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}