import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/presentation/resources/routes_manager.dart';

import '../../resources/assets_manager.dart';
import '../../resources/values_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double s = AppSize.s1;
  double y = AppSize.s0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      animationBehavior: AnimationBehavior.preserve,
    );
    _animationController.addListener(() {
      setState(() {
        s = AppSize.s1 + _animationController.value / 8;
        y = AppSize.s0 + _animationController.value * AppSize.s30;
      });
    });
    Future.delayed(const Duration(seconds: 1), () {
      _animationController.forward();
    });
    Future.delayed(const Duration(milliseconds: 1100), () {
      Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

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
            delay: const Duration(milliseconds: 500),
            begin: AppSize.s0,
            end: AppSize.s0_5,
          ),
          Center(
            child: Transform.translate(
              offset: Offset(AppSize.s0, y),
              child: Transform.scale(
                scaleX: s,
                child: SizedBox.square(
                  dimension: AppSize.s150,
                  child: Hero(
                    tag: 'app-logo',
                    child: Transform.flip(
                      flipX: true,
                      child: SvgPicture.asset(SVGAssets.logo),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
