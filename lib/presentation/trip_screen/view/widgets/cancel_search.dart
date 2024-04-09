import 'package:flutter/material.dart';
import 'package:speedy_go/presentation/trip_screen/view/widgets/trip_body.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/trip_viewmodel.dart';

class CancelSearch extends StatelessWidget {
  const CancelSearch({super.key, required this.viewModel});

  final TripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel.pageChange(3);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              AppStrings.searchNearestDriver,
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              AppStrings.pleaseWait,
              style: AppTextStyles.SelectionTextStyle(
                  context, ColorManager.black, FontSize.f22),
            ),
            const Padding(
              padding: EdgeInsets.all(AppPadding.p20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(
                    flex: 15,
                  ),
                  Icon(
                    Icons.circle,
                    size: AppSize.s12,
                  ),
                  Spacer(),
                  Icon(
                    Icons.circle,
                    size: AppSize.s12,
                  ),
                  Spacer(),
                  Icon(
                    Icons.circle,
                    size: AppSize.s12,
                  ),
                  Spacer(
                    flex: 15,
                  ),
                ],
              ),
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
