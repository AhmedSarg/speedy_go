import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
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
              AppStrings.selectDriver,
              style: AppTextStyles.SelectionTextStyle(
                  context, ColorManager.black, FontSize.f24),
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
                          style: AppTextStyles.SelectionTextStyle(
                            context,
                            ColorManager.white,
                            FontSize.f18,
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
                                viewModel.getSelectedDriver.location,
                                style: AppTextStyles.SelectionTextStyle(
                                  context,
                                  ColorManager.white,
                                  FontSize.f12,
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
                          style: AppTextStyles.SelectionTextStyle(
                            context,
                            ColorManager.white,
                            FontSize.f12,
                          ),
                        ),
                        Text(
                          viewModel.getSelectedDriver.license,
                          style: AppTextStyles.SelectionTextStyle(
                            context,
                            ColorManager.white,
                            FontSize.f12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: (context.width() - AppSize.s54) / 3,
                    child: Center(
                      child: Text(
                        "Color: ${viewModel.getSelectedDriver.color}",
                        style: AppTextStyles.SelectionTextStyle(
                          context,
                          ColorManager.white,
                          FontSize.f12,
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
                          viewModel.getSelectedDriver.rate.toString(),
                          style: AppTextStyles.SelectionTextStyle(
                            context,
                            ColorManager.white,
                            FontSize.f12,
                          ),
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
                "Will arrive in ${viewModel.getSelectedDriver.time} mins.",
                style: AppTextStyles.SelectionTextStyle(
                  context,
                  ColorManager.white,
                  FontSize.f12,
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.lightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s15),
            ),
            fixedSize: const Size(AppSize.s200, AppSize.s50),
          ),
          child: Text(
            AppStrings.endTrip,
            style: AppTextStyles.SelectionTextStyle(
                context, ColorManager.white, FontSize.f22),
          ),
        ),
      ],
    );
  }
}
