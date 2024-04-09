import 'package:flutter/material.dart';
import 'package:speedy_go/presentation/trip_screen/view/widgets/trip_body.dart';

import '../../../../domain/models/enums.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/trip_viewmodel.dart';

class Selection extends StatelessWidget {
  const Selection({super.key, required this.viewModel});

  final TripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel.pageChange(0);
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Item(
                asset: SVGAssets.car,
                name: TripType.car.toString(),
                color: viewModel.colorItemCar,
                viewModel: viewModel),
            Item(
                asset: SVGAssets.tuktuk,
                name: TripType.tuktuk.toString(),
                color: viewModel.colorItemTuktuk,
                viewModel: viewModel),
          ],
        ),
        ElevatedButton(
          onPressed: () {},
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
