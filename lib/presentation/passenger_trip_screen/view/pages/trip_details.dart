import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/passenger_trip_viewmodel.dart';

class TripDetails extends StatelessWidget {
  const TripDetails({super.key});

  static late PassengerTripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = PassengerTripViewModel.get(context);
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
                  Container(
                    width: AppSize.s60,
                    height: AppSize.s60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ColorManager.secondary,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: viewModel.getSelectedDriver.imagePath.contains('https')
                        ? CachedNetworkImage(
                      imageUrl: viewModel.getSelectedDriver.imagePath,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (_, __, progress) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(AppSize.s25),
                            child: CircularProgressIndicator(
                              color: ColorManager.secondary,
                              strokeWidth: AppSize.s1,
                              strokeCap: StrokeCap.round,
                            ),
                          ),
                        );
                      },
                    )
                        : Image.asset(
                      viewModel.getSelectedDriver.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
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
                          viewModel.getSelectedDriver.rate.toStringAsFixed(1),
                          style: AppTextStyles.tripScreenDetailsPageRateTextStyle(context),
                        ),
                        const SizedBox(width: AppSize.s5),
                        SvgPicture.asset(SVGAssets.star, height: AppSize.s10),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: AppSize.s50,
          width: AppSize.infinity,
          child: ElevatedButton(
            onPressed: viewModel.shareTrip,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s15),
              ),
            ),
            child: Text(
              AppStrings.tripScreenDetailsPageShareTrip.tr(),
              style: AppTextStyles.tripScreenDetailsPageButtonTextStyle(context),
            ),
          ),
        ),
      ],
    );
  }
}
