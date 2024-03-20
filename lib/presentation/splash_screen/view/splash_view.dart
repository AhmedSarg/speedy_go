import 'package:flutter/material.dart';
import 'package:speedy_go/presentation/splash_screen/view/widgets/splash_screen_driver_body.dart';
import 'package:speedy_go/presentation/splash_screen/view/widgets/splash_screen_passenger_body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(

      body: SplashScreenPassengerBody(),
    );
  }
}
