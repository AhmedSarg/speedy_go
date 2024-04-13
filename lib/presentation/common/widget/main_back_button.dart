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
    return ElevatedButton(
      onPressed: onTap,
      style: IconButton.styleFrom(
        backgroundColor: ColorManager.grey,
        foregroundColor: ColorManager.primary,
        shape: const CircleBorder(),
        padding: const EdgeInsets.only(left: AppPadding.p4),
      ),
      child: const Icon(
        Icons.arrow_back_ios,
        size: AppSize.s12,
        color: ColorManager.white,
      ),
    );
  }
}