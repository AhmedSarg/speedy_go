import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:speedy_go/presentation/selection_old_screen/viewmodel/selection_old_viewmodel.dart';

import '../../../../domain/models/enums.dart';
import '../../../common/data_intent/data_intent.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';
import 'selection_old_tile.dart';

class SelectionOldBody extends StatelessWidget {
  const SelectionOldBody({super.key, required this.viewModel});

  final SelectionViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SelectionOldTile(
                type: UserType.driver,
                title: AppStrings.selectionScreenDriverTile.tr(),
                imagePath: ImageAssets.driverSelectionTileImage,
                onTap: () {
                  viewModel.setSelected(UserType.driver);
                    DataIntent.setSelection(viewModel.select);
                }),
            SelectionOldTile(
                type: UserType.passenger,
                title: AppStrings.selectionScreenPassengerTile.tr(),
                imagePath: ImageAssets.passengerSelectionTileImage,
                onTap: () {
                    viewModel.setSelected(UserType.passenger);
                    DataIntent.setSelection(viewModel.select);
                }),
          ],
        ),
        AnimatedPositioned(
          top: DataIntent.getSelection() == UserType.driver
              ? context.height() * .8 - AppSize.s35
              : (DataIntent.getSelection() == UserType.passenger
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



