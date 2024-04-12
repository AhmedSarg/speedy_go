import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/trip_viewmodel.dart';

class TripDetails extends StatelessWidget {
  const TripDetails({super.key});

  static late TripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = TripViewModel.get(context);
    return Column(
      children: [
        Column(
          children: [
            Text(
              AppStrings.tripScreenDetailsPageTitle.tr(),
              style: AppTextStyles.tripScreenDetailsPageTitleTextStyle(context),
            ),
            const Divider(
              color: ColorManager.grey,
              indent: AppSize.s20,
              endIndent: AppSize.s20,
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(AppPadding.p10),
          margin: const EdgeInsets.symmetric(vertical: AppMargin.m20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s35),
            color: ColorManager.darkBlack,
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
                          viewModel.getSelectedDriver.name,
                          style: AppTextStyles.tripScreenDetailsPageNameTextStyle(context)
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
                                viewModel.getSelectedDriver.location,
                                style: AppTextStyles.tripScreenDetailsPageLocationTextStyle(context),
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
                      child: IconButton(
                        onPressed: () {
                          launchUrlString('tel://${viewModel.getSelectedDriver.phoneNumber}');
                        },
                        icon: SvgPicture.asset(SVGAssets.fillPhone),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: (context.width() - AppSize.s54) / 3,
                    child: Column(
                      children: [
                        Text(
                          viewModel.getSelectedDriver.car,
                          style: AppTextStyles.tripScreenDetailsPageCarTextStyle(context),
                        ),
                        Text(
                          viewModel.getSelectedDriver.license,
                          style: AppTextStyles.tripScreenDetailsPageLicenseTextStyle(context),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: (context.width() - AppSize.s54) / 3,
                    child: Center(
                      child: Text(
                        "${AppStrings.tripScreenDetailsPageColor.tr()}: ${viewModel.getSelectedDriver.color}",
                        style: AppTextStyles.tripScreenDetailsPageColorTextStyle(context),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: (context.width() - AppSize.s54) / 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          viewModel.getSelectedDriver.rate.toString(),
                          style: AppTextStyles.tripScreenDetailsPageRateTextStyle(context),
                        ),
                        const SizedBox(width: AppSize.s5),
                        SvgPicture.asset(SVGAssets.star, height: AppSize.s10),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s10),
              Text(
                "${AppStrings.tripScreenDetailsPageArrival1.tr()}${viewModel.getSelectedDriver.time}${AppStrings.tripScreenDetailsPageArrival2.tr()}",
                style: AppTextStyles.tripScreenDetailsPageTimeTextStyle(context),
              ),
            ],
          ),
        ),
        SizedBox(
          height: AppSize.s50,
          width: AppSize.infinity,
          child: ElevatedButton(
            onPressed: () {
              viewModel.nextPage();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s15),
              ),
            ),
            child: Text(
              AppStrings.tripScreenDetailsPageEndTrip.tr(),
              style: AppTextStyles.tripScreenDetailsPageButtonTextStyle(context),
            ),
          ),
        ),
      ],
    );
  }
}
