import 'package:flutter/material.dart';
import 'package:speedy_go/presentation/trip_screen/view/widgets/trip_body.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/trip_viewmodel.dart';

class CancelTrip extends StatelessWidget {
  const CancelTrip({super.key, required this.viewModel});

  final TripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel.pageChange(1);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              AppStrings.chooseYourVehicle,
              style: AppTextStyles.SelectionTextStyle(
                  context, ColorManager.black, FontSize.f22),
            ),
            const Divider(
              color: ColorManager.black,
              indent: AppSize.s20,
              endIndent: AppSize.s20,
            ),
          ],
        ),
        Item(
          color: ColorManager.darkBlack,
          name: viewModel.selectedName.toString(),
          asset: viewModel.selectedAsset,
          viewModel: viewModel,
        ),
        Column(
          children: [
            Text(
              "EGP 50, cash",
              style: AppTextStyles.SelectionTextStyle(
                  context, ColorManager.black, FontSize.f18),
            ),
            Text(
              "Recommended fare, adjustable",
              style: AppTextStyles.SelectionTextStyle(
                  context, ColorManager.black, FontSize.f10),
            ),
            const Divider(
              color: ColorManager.black,
              indent: AppSize.s50,
              endIndent: AppSize.s50,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.error,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s10),
                ),
                fixedSize: const Size(AppSize.s300, AppSize.s50),
              ),
              child: Text(
                AppStrings.cancel,
                style: AppTextStyles.SelectionTextStyle(
                    context, ColorManager.white, FontSize.f22),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
