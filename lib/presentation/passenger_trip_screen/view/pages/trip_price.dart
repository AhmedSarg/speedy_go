import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/passenger_trip_viewmodel.dart';

class TripPrice extends StatelessWidget {
  const TripPrice({super.key});

  static late PassengerTripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = PassengerTripViewModel.get(context);
    print('built');
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: AppPadding.p20),
          child: Column(
            children: [
              Text(
                "EGP ${viewModel.getPrice.toString()}",
                style: AppTextStyles.tripScreenPricePageTitleTextStyle(context),
              ),
              const Divider(
                color: ColorManager.black,
                indent: AppSize.s20,
                endIndent: AppSize.s20,
              ),
              Text(
                AppStrings.tripScreenPricePageDescription.tr(),
                style: AppTextStyles.tripScreenPricePageDescriptionTextStyle(
                    context),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p40,
            vertical: AppPadding.p30,
          ),
          child: TextField(
            controller: viewModel.getPriceController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: ColorManager.white),
            onChanged: (v) {
              print(v);
              viewModel.setPrice = v;
            },
            decoration: InputDecoration(
              fillColor: ColorManager.darkShadeOfGrey,
              filled: true,
              hintText: AppStrings.tripScreenPricePagePlaceholder.tr(),
              hintStyle: AppTextStyles.tripScreenPricePagePlaceholderTextStyle(
                  context),
              hoverColor: ColorManager.lightBlue,
              prefixIconConstraints: const BoxConstraints(),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(AppPadding.p10),
                child: SvgPicture.asset(SVGAssets.cash),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s14),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s14),
                borderSide: const BorderSide(
                  color: ColorManager.secondary,
                  width: AppSize.s1,
                ),
              ),
            ),
          ),
        ),
        Column(
          children: [
            const Divider(color: ColorManager.black),
            SizedBox(
              height: AppSize.s50,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        viewModel.prevPage();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.error,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s10),
                        ),
                      ),
                      child: Text(
                        AppStrings.tripScreenPricePageBack.tr(),
                        style: AppTextStyles.tripScreenPricePageButtonTextStyle(
                            context),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSize.s10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        viewModel.nextPage();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s10),
                        ),
                      ),
                      child: Text(
                        AppStrings.tripScreenPricePageNext.tr(),
                        style: AppTextStyles.tripScreenPricePageButtonTextStyle(
                            context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
