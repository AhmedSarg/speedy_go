import 'package:flutter/material.dart';
import 'package:speedy_go/presentation/selection_screen/view/widgets/selection_body.dart';

import '../../resources/assets_manager.dart';
import '../../resources/values_manager.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: AppSize.infinity,
        height: AppSize.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssets.loginBackgroundImage),
            fit: BoxFit.cover
          ),
        ),
        child: const SelectionBody(),
      ),
    );
  }
}
