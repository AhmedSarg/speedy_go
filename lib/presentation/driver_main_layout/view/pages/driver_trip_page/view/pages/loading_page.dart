import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../resources/assets_manager.dart';
import '../../../../../../resources/values_manager.dart';

class DriverTripLoadingPage extends StatelessWidget {
  const DriverTripLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p50),
      child: Center(
        child: Lottie.asset(LottieAssets.loading),
      ),
    );
  }
}
