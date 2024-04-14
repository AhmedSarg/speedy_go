import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:speedy_go/domain/models/enums.dart';
import 'package:speedy_go/presentation/resources/strings_manager.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/passenger_map_viewmodel.dart';

class PassengerMapBody extends StatelessWidget {
  const PassengerMapBody({super.key});

  static late PassengerMapViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = PassengerMapViewModel.get(context);
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p50),
              child: SvgPicture.asset(
                SVGAssets.logo,
                width: AppSize.s60,
                height: AppSize.s60,
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                height: AppSize.s100,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: AppSize.s1,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(AppSize.s20),
                    topLeft: Radius.circular(AppSize.s20),
                  ),
                  color: ColorManager.lightShadeOfGrey,
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        viewModel.goToMap(LocationMapType.pickup);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.transparent,
                        foregroundColor: ColorManager.black,
                        elevation: AppSize.s0,
                        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
                        shape: const ContinuousRectangleBorder(),
                        fixedSize: const Size(AppSize.infinity, AppSize.s49),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width:
                                (context.width() - AppSize.s62) *
                                    .2,
                            child: const Center(
                              child: CircleAvatar(
                                backgroundColor: ColorManager.lightGreen,
                                radius: AppSize.s4,
                              ),
                            ),
                          ),
                          Text(
                            "${AppStrings.tripMapScreenFrom.tr()} : ",
                            style: AppTextStyles.tripMapScreenFromToTextStyle(
                                context),
                          ),
                          Expanded(
                            child: Text(
                              AppStrings.tripMapScreenPlaceholder.tr(),
                              style:
                                  AppTextStyles.tripMapScreenPlaceholderTextStyle(
                                      context),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: ColorManager.mutedBlue,
                      height: AppSize.s2,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        viewModel.goToMap(LocationMapType.destination);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.transparent,
                        foregroundColor: ColorManager.black,
                        elevation: AppSize.s0,
                        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
                        shape: const ContinuousRectangleBorder(),
                        fixedSize: const Size(AppSize.infinity, AppSize.s49),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width:
                                (context.width() - AppSize.s62) *
                                    .2,
                            child: const Center(
                              child: Icon(
                                Icons.arrow_drop_down,
                                size: AppSize.s40,
                              ),
                            ),
                          ),
                          Text(
                            "${AppStrings.tripMapScreenTo.tr()} : ",
                            style: AppTextStyles.tripMapScreenFromToTextStyle(
                                context),
                          ),
                          Expanded(
                            child: Text(
                              AppStrings.tripMapScreenPlaceholder.tr(),
                              style: AppTextStyles
                                  .tripMapScreenPlaceholderTextStyle(context),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: AppSize.s25 + AppSize.s4,
                bottom: AppSize.s25 + AppSize.s4,
                left: AppSize.s10,
                child: SizedBox(
                  width: (context.width() - AppSize.s62) * .2,
                  child: Center(
                    child: Container(
                      color: ColorManager.black,
                      width: AppSize.s1,
                      height: AppSize.s42,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(color: ColorManager.mutedBlue),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  foregroundColor: ColorManager.transparent,
                ),
                child: Text(
                  AppStrings.tripMapScreenCancel.tr(),
                  style:
                      AppTextStyles.tripMapScreenFromToButtonTextStyle(context),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
