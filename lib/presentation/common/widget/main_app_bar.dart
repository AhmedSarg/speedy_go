import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';

AppBar buildMainAppBar(
  BuildContext context,
  Color? color, [
  Function()? onTap,
]) {
  color ??= ColorManager.primary;
  return AppBar(
    backgroundColor: color,
    leading: (Navigator.canPop(context))
        ? Center(
          child: Padding(
            padding: const EdgeInsets.only(left: AppPadding.p8),
            child: CircleAvatar(
                radius: AppSize.s18,
                backgroundColor: ColorManager.grey,
                child: IconButton(
                  onPressed: onTap ??
                      () {
                        Navigator.pop(context);
                      },
                  padding: const EdgeInsets.only(left: AppPadding.p4),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                  color: ColorManager.white,
                  iconSize: AppSize.s12,
                ),
              ),
          ),
        )
        : null,
    elevation: AppSize.s0,
    shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
  );
}
