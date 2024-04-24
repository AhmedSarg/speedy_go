import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';
import 'package:speedy_go/presentation/splash_screen/viewmodel/splash_viewmodel.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/values_manager.dart';


class SplashBodyScreen extends StatefulWidget {
  const SplashBodyScreen({Key? key, required this.viewModel}) : super(key: key);
final SplashViewModel viewModel;
  @override
  State<SplashBodyScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashBodyScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  double s = AppSize.s1;
  double y = AppSize.s0;
  double rot = AppSize.s0;
  Duration animationDuration = const Duration(seconds: 1);
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: animationDuration,
    );

    animationController.addListener(() {
      setState(() {
        rot = animationController.value * pi;
      });
    });

    // Start initial animation
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return; // Ensure widget is still mounted
      animationController.forward();
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      animationController.addListener(() {
        setState(() {
          s = AppSize.s1 + animationController.value / 8;
          y = AppSize.s0 + animationController.value * AppSize.s30;
        });
      });
      animationController.reset();
      animationController.forward();
    });

    Future.delayed(const Duration(milliseconds: 3600), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.black,
      body: Stack(
        children: [
          Image.asset(
            ImageAssets.loginBackgroundImage,
            height: AppSize.infinity,
            fit: BoxFit.cover,
          ).animate().fade(
            duration: const Duration(milliseconds: 500),
            delay: const Duration(seconds: 3, milliseconds: 100),
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
                    child: Transform(
                      transform: Matrix4.rotationY(rot),
                      alignment: Alignment.center,
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