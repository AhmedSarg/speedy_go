import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:speedy_go/app/extensions.dart';

import '../../../../domain/models/domain.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/passenger_trip_viewmodel.dart';
import 'trip_search.dart';

class TripDriver extends StatelessWidget {
  const TripDriver({super.key});

  static late PassengerTripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = PassengerTripViewModel.get(context);
    return StreamBuilder(
      stream: viewModel.getDrivers,
      builder: (context, drivers) {
        if (drivers.hasData && drivers.data!.isNotEmpty) {
          if (viewModel.getSelectedDriver.id.isNotEmpty &&
              !viewModel.getDriversIds
                  .sublist(
                      viewModel.getDriversIds.length - drivers.data!.length)
                  .contains(viewModel.getSelectedDriver.id)) {
            viewModel.setSelectedDriver = null;
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    AppStrings.tripScreenDriverSelectionPageTitle.tr(),
                    style: AppTextStyles
                        .tripScreenDriverSelectionPageTitleTextStyle(context),
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
                    itemCount: drivers.data!.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder<TripDriverModel>(
                        future: drivers.data![index],
                        builder: (context, driver) {
                          if (driver.hasData) {
                            viewModel.getDriversIds.add(driver.data!.id);
                            return Card(
                              viewModel: viewModel,
                              driver: driver.data!,
                            );
                          } else {
                            return Center(
                              child: Lottie.asset(
                                LottieAssets.loading,
                                height: AppSize.s100,
                              ),
                            );
                          }
                        },
                      );
                    },
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
                  onPressed: (viewModel.getSelectedDriver.id.isNotEmpty)
                      ? () {
                          viewModel.acceptDriver();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.darkGreen,
                    disabledBackgroundColor:
                        ColorManager.green.withOpacity(0.7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s15),
                    ),
                  ),
                  child: Text(
                    AppStrings.tripScreenDriverSelectionPageConfirm.tr(),
                    style: AppTextStyles
                        .tripScreenDriverSelectionPageButtonTextStyle(context),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const TripSearch();
        }
      },
    );
  }
}

class Card extends StatelessWidget {
  const Card({
    super.key,
    required this.viewModel,
    required this.driver,
  });

  final PassengerTripViewModel viewModel;
  final TripDriverModel driver;

  @override
  Widget build(BuildContext context) {
    bool driverSelected = driver.id == viewModel.getSelectedDriver.id;
    Color textColor = driverSelected ? ColorManager.white : ColorManager.black;
    return GestureDetector(
      onTap: () {
        if (driverSelected) {
          viewModel.setSelectedDriver = null;
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
                Container(
                  width: AppSize.s60,
                  height: AppSize.s60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: driverSelected
                          ? ColorManager.secondary
                          : ColorManager.primary,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: driver.imagePath.contains('https')
                      ? CachedNetworkImage(
                          imageUrl: driver.imagePath,
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
                          driver.imagePath,
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
                        driver.rate.toStringAsFixed(1),
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
