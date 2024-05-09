import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_go/app/extensions.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/rate_viewmodel.dart';

class RateBody extends StatelessWidget {
  const RateBody({super.key, required this.viewModel});

  final RateViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            SizedBox.square(
              dimension: context.width() * .4,
              child: SvgPicture.asset(SVGAssets.logo),
            ),
            const Spacer(),
            Text(
              AppStrings.rateScreenTitle.tr(),
              style: AppTextStyles.rateScreenTitleTextStyle(context),
            ),
            const SizedBox(height: AppSize.s10),
            RatingBar(viewModel: viewModel),
            const SizedBox(height: AppSize.s10),
            Text(
              AppStrings.rateScreenDescription.tr(),
              style: AppTextStyles.rateScreenDescriptionTextStyle(context),
            ),
            const Spacer(flex: 3),
            Container(
              width: AppSize.infinity,
              height: AppSize.s50,
              margin: const EdgeInsets.symmetric(horizontal: AppMargin.m64),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.error,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s10),
                  ),
                ),
                child: Text(
                  AppStrings.rateScreenCancel.tr(),
                  style: AppTextStyles.rateScreenButtonTextStyle(context),
                ),
              ),
            ),
            const SizedBox(height: AppSize.s20),
            Container(
              width: AppSize.infinity,
              height: AppSize.s50,
              margin: const EdgeInsets.symmetric(horizontal: AppMargin.m32),
              child: ElevatedButton(
                onPressed: (viewModel.indexRate != 0)
                    ? () {
                        viewModel.rateDriver();
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.darkGreen,
                  disabledBackgroundColor:
                      ColorManager.darkGreen.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s15),
                  ),
                ),
                child: Text(
                  AppStrings.rateScreenConfirm.tr(),
                  style: AppTextStyles.rateScreenButtonTextStyle(context),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class RatingBar extends StatelessWidget {
  const RatingBar({super.key, required this.viewModel});

  final RateViewModel viewModel;

  SvgPicture star(bool ok) {
    if (ok) {
      return SvgPicture.asset(SVGAssets.fillStar);
    } else {
      return SvgPicture.asset(SVGAssets.emptyStar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s30,
      child: Center(
        child: ListView.separated(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) => GestureDetector(
            onTap: () {
              viewModel.rated(i + 1);
            },
            child: star(
              viewModel.changeRate(i + 1),
            ),
          ),
          separatorBuilder: (_, __) => const SizedBox(width: AppSize.s10),
        ),
      ),
    );
  }
}
