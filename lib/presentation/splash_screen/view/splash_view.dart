import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/sl.dart';
import '../../base/base_states.dart';
import '../../base/cubit_listener.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';
import '../states/splash_states.dart';
import '../viewmodel/splash_viewmodel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  double s = AppSize.s1;
  double y = AppSize.s0;
  double rot = AppSize.s0;
  Duration animationDuration = const Duration(seconds: 1);
  bool fade = false;

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
  }

  void startAnimation() {
    if (!mounted) return;
    animationController.addListener(() {
      setState(
        () {
          rot = animationController.value * pi;
        },
      );
    });
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (!mounted) return;
        animationController.forward();
      },
    );
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (!mounted) return;
        animationController.clearListeners();
        animationController.addListener(
          () {
            setState(
              () {
                s = AppSize.s1 + animationController.value / 8;
                y = AppSize.s0 + animationController.value * AppSize.s30;
              },
            );
          },
        );
        animationController.reset();
        animationController.forward();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.black,
      body: BlocProvider(
        create: (context) => SplashViewModel(sl(), sl())..start(),
        child: BlocConsumer<SplashViewModel, BaseStates>(
          listener: (context, state) {
            if (state is UserNotSignedState) {
              startAnimation();
              Future.delayed(
                const Duration(milliseconds: 3100),
                () {
                  Navigator.pushReplacementNamed(
                      context, Routes.onBoardingRoute);
                },
              );
            } else if (state is PassengerSignedState) {
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.pushReplacementNamed(context, Routes.mainLayoutRoute);
              });
            } else if (state is DriverSignedState) {
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.pushReplacementNamed(
                    context, Routes.driverMainLayoutRoute);
              });
            } else if (state is BusDriverSignedState) {
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.pushReplacementNamed(context, Routes.busesRoute);
              });
            }
            baseListener(context, state);
          },
          builder: (context, state) {
            return Stack(
              children: [
                (state is UserNotSignedState)
                    ? Image.asset(
                        ImageAssets.loginBackgroundImage,
                        width: AppSize.infinity,
                        height: AppSize.infinity,
                        fit: BoxFit.cover,
                      ).animate().fade(
                          duration: const Duration(milliseconds: 500),
                          delay: const Duration(seconds: 3, milliseconds: 100),
                          begin: AppSize.s0,
                          end: AppSize.s0_5,
                        )
                    : const SizedBox(),
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
            );
          },
        ),
      ),
    );
  }
}
