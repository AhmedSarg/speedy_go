import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/app/extensions.dart';

import '../../../../domain/models/enums.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/trip_viewmodel.dart';

class TripBody extends StatelessWidget {
  const TripBody({
    super.key,
    required this.viewModel,
  });

  final TripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        viewModel.prevPage();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p20),
              child: Back(onTap: viewModel.prevPage),
            ),
          ),
          Container(
            width: AppSize.infinity,
            padding: const EdgeInsets.all(AppPadding.p16),
            decoration: const BoxDecoration(
              color: ColorManager.lightBlack,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSize.s20),
                topRight: Radius.circular(AppSize.s20),
              ),
            ),
            child: viewModel.getPage,
          ),
        ],
      ),
    );
  }
}

class Back extends StatelessWidget {
  const Back({
    super.key,
    required this.onTap,
  });

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: AppSize.s18,
      backgroundColor: ColorManager.grey,
      child: IconButton(
        onPressed: onTap,
        padding: const EdgeInsets.only(left: AppPadding.p4),
        icon: const Icon(
          Icons.arrow_back_ios,
        ),
        color: ColorManager.white,
        iconSize: AppSize.s12,
      ),
    );
  }
}

class SelectionItem extends StatelessWidget {
  const SelectionItem({
    super.key,
    required this.tripType,
    required this.viewModel,
  });

  final TripViewModel viewModel;
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
                tripType == TripType.car ? 'Car' : 'Tuktuk',
                style: AppTextStyles.SelectionTextStyle(
                    context, ColorManager.white, FontSize.f22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
