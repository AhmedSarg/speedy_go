import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:speedy_go/domain/models/domain.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
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
        ElevatedButton(
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
            fixedSize: const Size(AppSize.s200, AppSize.s50),
          ),
          child: Text(
            AppStrings.confirm,
            style: AppTextStyles.SelectionTextStyle(
                context, ColorManager.white, FontSize.f22),
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
                        style: AppTextStyles.SelectionTextStyle(
                          context,
                          textColor,
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
                              driver.location,
                              style: AppTextStyles.SelectionTextStyle(
                                context,
                                textColor,
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
                    child: Text(
                      "${driver.price}, cash",
                      style: AppTextStyles.SelectionTextStyle(
                        context,
                        textColor,
                        FontSize.f12,
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
                        style: AppTextStyles.SelectionTextStyle(
                          context,
                          textColor,
                          FontSize.f12,
                        ),
                      ),
                      Text(
                        driver.license,
                        style: AppTextStyles.SelectionTextStyle(
                          context,
                          textColor,
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
                      "Color: ${driver.color}",
                      style: AppTextStyles.SelectionTextStyle(
                        context,
                        textColor,
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
                        driver.rate.toString(),
                        style: AppTextStyles.SelectionTextStyle(
                          context,
                          textColor,
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
            const SizedBox(height: AppSize.s5),
            Text(
              "Will arrive in ${driver.time} mins.",
              style: AppTextStyles.SelectionTextStyle(
                context,
                textColor,
                FontSize.f12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
