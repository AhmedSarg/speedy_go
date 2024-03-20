import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/custom_icons_icons.dart';
import '../../resources/values_manager.dart';

AppBar buildMainAppBar(BuildContext context, Color? color, [double elevation = 4]) {
  color ??= ColorManager.primary;
  return AppBar(
    backgroundColor: color,
    leading: (Navigator.canPop(context))
        ? IconButton(
      icon: const Icon(CustomIcons.back, size: AppSize.s35,),
      onPressed: () {
        Navigator.pop(context);
      },
    )
        : null,
    actions: [
      SvgPicture.asset(
        SVGAssets.ieeeLogo,
        width: AppSize.s80,
      ),
      const SizedBox(width: AppSize.s20,),
    ],
    elevation: elevation,
    shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
  );
}