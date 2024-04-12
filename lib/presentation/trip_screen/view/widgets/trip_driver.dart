import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/app/extensions.dart';

import '../../../../domain/models/domain.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/trip_viewmodel.dart';

class TripDriver extends StatelessWidget {
  const TripDriver({super.key});

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
              AppStrings.tripScreenDriverSelectionPageTitle.tr(),
              style: AppTextStyles.tripScreenDriverSelectionPageTitleTextStyle(
                  context),
            ),
            const Divider(
              color: ColorManager.grey,
              indent: AppSize.s20,
              endIndent: AppSize.s20,
            ),
          ],
        ),
        const SizedBox(height: AppSize.s20),
        Container(
          constraints: BoxConstraints(
            maxHeight: context.height() * .6,
            minHeight: AppSize.s0,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.getDrivers.length,
              itemBuilder: (context, index) =>
                  Card(viewModel: viewModel, index: index),
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppSize.s20),
            ),
          ),
        ),
        const SizedBox(height: AppSize.s20),
        SizedBox(
          height: AppSize.s50,
          width: AppSize.infinity,
          child: ElevatedButton(
            onPressed: (viewModel.getSelectedDriver.id != -1)
                ? () {
                    viewModel.nextPage();
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.darkGreen,
              disabledBackgroundColor: ColorManager.green.withOpacity(0.7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s15),
              ),
            ),
            child: Text(
              AppStrings.tripScreenDriverSelectionPageConfirm.tr(),
              style: AppTextStyles.tripScreenDriverSelectionPageButtonTextStyle(
                  context),
            ),
          ),
        ),
      ],
    );
  }
}

class Card extends StatelessWidget {
  const Card({
    super.key,
    required this.viewModel,
    required this.index,
  });

  final TripViewModel viewModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    final TripDriverModel driver = viewModel.getDrivers[index];
    bool driverSelected = driver == viewModel.getSelectedDriver;
    Color textColor = driverSelected ? ColorManager.white : ColorManager.black;
    return GestureDetector(
      onTap: () {
        if (driverSelected) {
          viewModel.setSelectedDriver = TripDriverModel.fake();
        } else {
          viewModel.setSelectedDriver = driver;
        }
      },
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s35),
          color: driverSelected
              ? ColorManager.darkBlack
              : ColorManager.transparent,
          border: Border.all(color: ColorManager.black),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                const CircleAvatar(radius: AppSize.s30),
                const SizedBox(width: AppSize.s10),
                SizedBox(
                  width: (context.width() - AppSize.s130) * .7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        driver.name,
                        style: AppTextStyles
                            .tripScreenDriverSelectionPageNameTextStyle(
                          context,
                          textColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            SVGAssets.location,
                            height: AppSize.s15,
                          ),
                          const SizedBox(width: AppSize.s5),
                          Expanded(
                            child: Text(
                              driver.location,
                              style: AppTextStyles
                                  .tripScreenDriverSelectionPageLocationTextStyle(
                                context,
                                textColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: (context.width() - AppSize.s130) * .3,
                  child: Center(
                    child: Text(
                      "${driver.price}, ${AppStrings.tripScreenDriverSelectionPageCash.tr()}",
                      style: AppTextStyles
                          .tripScreenDriverSelectionPagePriceTextStyle(
                        context,
                        textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: (context.width() - AppSize.s54) / 3,
                  child: Column(
                    children: [
                      Text(
                        driver.car,
                        style: AppTextStyles
                            .tripScreenDriverSelectionPageCarTextStyle(
                          context,
                          textColor,
                        ),
                      ),
                      Text(
                        driver.license,
                        style: AppTextStyles
                            .tripScreenDriverSelectionPageLicenseTextStyle(
                          context,
                          textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: (context.width() - AppSize.s54) / 3,
                  child: Center(
                    child: Text(
                      "${AppStrings.tripScreenDriverSelectionPageColor.tr()}: ${driver.color}",
                      style: AppTextStyles
                          .tripScreenDriverSelectionPageColorTextStyle(
                        context,
                        textColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: (context.width() - AppSize.s54) / 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        driver.rate.toString(),
                        style: AppTextStyles
                            .tripScreenDriverSelectionPageRateTextStyle(
                          context,
                          textColor,
                        ),
                      ),
                      const SizedBox(width: AppSize.s5),
                      SvgPicture.asset(SVGAssets.star, height: AppSize.s10),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s5),
            Text(
              "${AppStrings.tripScreenDriverSelectionPageArrival1.tr()}${driver.time}${AppStrings.tripScreenDriverSelectionPageArrival2.tr()}",
              style: AppTextStyles.tripScreenDriverSelectionPageTimeTextStyle(
                context,
                textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}