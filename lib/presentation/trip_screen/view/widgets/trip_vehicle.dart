import 'package:flutter/material.dart';

import '../../../../domain/models/enums.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/trip_viewmodel.dart';
import 'trip_body.dart';

class TripVehicle extends StatelessWidget {
  const TripVehicle({super.key});

  static late TripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = TripViewModel.get(context);
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SelectionItem(
                tripType: TripType.car,
                viewModel: viewModel,
              ),
              const SizedBox(width: AppSize.s20),
              SelectionItem(
                tripType: TripType.tuktuk,
                viewModel: viewModel,
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            viewModel.nextPage();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.lightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s10),
            ),
            fixedSize: const Size(AppSize.s300, AppSize.s50),
          ),
          child: Text(
            AppStrings.findDriver,
            style: AppTextStyles.SelectionTextStyle(
                context, ColorManager.white, FontSize.f22),
          ),
        ),
      ],
    );
  }
}
