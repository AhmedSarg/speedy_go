import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';

class Back extends StatelessWidget {
  const Back({
    super.key,
    required this.onTap,
  });

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: AppSize.s18,
      backgroundColor: ColorManager.grey,
      child: IconButton(
        onPressed: onTap,
        padding: const EdgeInsets.only(left: AppPadding.p4),
        icon: const Icon(
          Icons.arrow_back_ios,
        ),
        color: ColorManager.white,
        iconSize: AppSize.s12,
      ),
    );
  }
}