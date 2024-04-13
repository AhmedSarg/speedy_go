import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/values_manager.dart';

class BusesLogonWidget extends StatelessWidget {
  const BusesLogonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return         Center(
      child: SizedBox(
        height: AppSize.s90,
        width: AppSize. s90,
        child: SvgPicture.asset(SVGAssets.logo),
      ),
    );

  }
}
