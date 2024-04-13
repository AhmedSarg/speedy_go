import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/app/extensions.dart';

import '../../../../domain/models/enums.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/passenger_trip_viewmodel.dart';

class TripVehicle extends StatelessWidget {
  const TripVehicle({super.key});

  static late PassengerTripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = PassengerTripViewModel.get(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              AppStrings.tripScreenVehicleSelectionPageTitle.tr(),
              style: AppTextStyles.tripScreenVehicleSelectionPageTitleTextStyle(context),
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
        SizedBox(
          height: AppSize.s50,
          width: AppSize.infinity,
          child: ElevatedButton(
            onPressed: viewModel.getTripType == null
                ? null
                : () {
                    viewModel.nextPage();
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s10),
              ),
            ),
            child: Text(
              AppStrings.tripScreenVehicleSelectionPageButton.tr(),
              style:
                  AppTextStyles.tripScreenVehicleSelectionPageButtonTextStyle(
                      context),
            ),
          ),
        ),
      ],
    );
  }
}

class SelectionItem extends StatelessWidget {
  const SelectionItem({
    super.key,
    required this.tripType,
    required this.viewModel,
  });

  final PassengerTripViewModel viewModel;
  final TripType tripType;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          viewModel.setTripType = tripType;
        },
        child: Container(
          padding: const EdgeInsets.all(AppPadding.p10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s20),
            border: Border.all(color: ColorManager.black),
            color: viewModel.getTripType == tripType
                ? ColorManager.darkBlack
                : ColorManager.transparent,
          ),
          child: Column(
            children: [
              SvgPicture.asset(
                tripType == TripType.car ? SVGAssets.car : SVGAssets.tuktuk,
                height: context.width() * .4,
              ),
              Text(
                tripType == TripType.car
                    ? AppStrings.tripScreenVehicleSelectionPageCar.tr()
                    : AppStrings.tripScreenVehicleSelectionPageTukTuk.tr(),
                style: AppTextStyles.tripScreenVehicleSelectionPageItemTextStyle(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
