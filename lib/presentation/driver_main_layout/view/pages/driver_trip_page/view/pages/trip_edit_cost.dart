import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/app/extensions.dart';

import '../../../../../../resources/assets_manager.dart';
import '../../../../../../resources/color_manager.dart';
import '../../../../../../resources/strings_manager.dart';
import '../../../../../../resources/text_styles.dart';
import '../../../../../../resources/values_manager.dart';
import '../../viewmodel/driver_trip_page_viewmodel.dart';

class EditCost extends StatelessWidget {
  const EditCost({super.key});

  static late DriverTripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = DriverTripViewModel.get(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: AppPadding.p20),
          child: Column(
            children: [
              Text(
                "EGP ${viewModel.getTripPrice}",
                style: AppTextStyles.tripScreenPricePageTitleTextStyle(context),
              ),
              Divider(
                color: ColorManager.grey.withOpacity(.5),
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
            controller: viewModel.getNewCostController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: ColorManager.white),
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
            Divider(
              color: ColorManager.grey.withOpacity(.5),
            ),
            SizedBox(
              height: AppSize.s50,
              width: context.width() - AppSize.s40,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        viewModel.findTrips();
                        viewModel.getNewCostController.clear();
                        viewModel.setNewCost = null;
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
                        viewModel.setNewCost =
                            int.parse(viewModel.getNewCostController.text);
                        viewModel.acceptTrip(
                          int.parse(viewModel.getNewCostController.text),
                        );
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
