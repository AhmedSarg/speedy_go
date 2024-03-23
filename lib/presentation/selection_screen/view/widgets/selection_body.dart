import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:speedy_go/presentation/common/data_intent/data_intent.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';
import 'package:speedy_go/presentation/resources/routes_manager.dart';
import 'package:speedy_go/presentation/resources/strings_manager.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

import '../../../../domain/models/enums.dart';
import '../../../resources/assets_manager.dart';
import 'selection_tile.dart';

class SelectionBody extends StatefulWidget {
  const SelectionBody({super.key});

  @override
  State<SelectionBody> createState() => _SelectionBodyState();
}

class _SelectionBodyState extends State<SelectionBody> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SelectionTile(
                type: Selection.driver,
                title: AppStrings.selectionScreenDriverTile.tr(),
                imagePath: ImageAssets.driverSelectionTileImage,
                onTap: () {
                  setState(() {
                    DataIntent.setSelection(Selection.driver);
                  });
                }),
            SelectionTile(
                type: Selection.passenger,
                title: AppStrings.selectionScreenPassengerTile.tr(),
                imagePath: ImageAssets.passengerSelectionTileImage,
                onTap: () {
                  setState(() {
                    DataIntent.setSelection(Selection.passenger);
                  });
                }),
          ],
        ),
        AnimatedPositioned(
          top: DataIntent.getSelection() == Selection.driver
              ? context.height() * .8 - AppSize.s35
              : (DataIntent.getSelection() == Selection.passenger
                  ? context.height() * .2 - AppSize.s35
                  : context.height() * .5 - AppSize.s35),
          left: context.width() / 2 - AppSize.s35,
          duration: const Duration(milliseconds: 300),
          child: SizedBox.square(
            dimension: AppSize.s70,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.loginRoute);
                },
                backgroundColor: ColorManager.primary,
                foregroundColor: ColorManager.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: AppSize.s2, color: ColorManager.white),
                  borderRadius: BorderRadius.circular(AppSize.s20),
                ),
                splashColor: ColorManager.white.withOpacity(.1),
                elevation: AppSize.s0,
                highlightElevation: AppSize.s0,
                focusElevation: AppSize.s0,
                hoverElevation: AppSize.s0,
                child: const Icon(
                  Icons.navigate_next_rounded,
                  size: AppSize.s40,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
