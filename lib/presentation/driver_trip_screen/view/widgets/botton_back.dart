import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_go/presentation/driver_trip_screen/viewmodel/driver_trip_viewmodel.dart';
import 'package:speedy_go/presentation/resources/assets_manager.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/values_manager.dart';

class BackOrExit extends StatelessWidget {
  const BackOrExit({super.key, required this.onTap, required this.viewModel});

  final Function() onTap;
  final DriverTripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: IconButton.styleFrom(
        backgroundColor: ColorManager.grey,
        foregroundColor: ColorManager.primary,
        shape: const CircleBorder(),
        padding: const EdgeInsets.only(left: AppPadding.p4),
      ),
      child: SvgPicture.asset(
        (viewModel.getIndexPage == 3) ? SVGAssets.arrowBack : SVGAssets.close,
      ),
    );
  }
}
