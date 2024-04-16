import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:speedy_go/presentation/resources/assets_manager.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

class TripLoading extends StatelessWidget {
  const TripLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p50),
        child: Lottie.asset(LottieAssets.loading),
      ),
    );
  }
}
