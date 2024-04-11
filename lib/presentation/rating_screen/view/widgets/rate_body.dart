import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_go/presentation/rating_screen/viewmodel/rate_viewmodel.dart';
import 'package:speedy_go/presentation/resources/assets_manager.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';

class RateBody extends StatelessWidget {
  const RateBody({super.key, required this.viewModel});

  final RateViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Back(),
        SvgPicture.asset(SVGAssets.logo,
            height: AppSize.s80, width: AppSize.s100),
        Column(
          children: [
            Text("How was last trip ?",
                style: AppTextStyles.SelectionTextStyle(
                    context, ColorManager.white, FontSize.f22)),

            Rating(viewModel: viewModel),

            Text("Help us by leaving feedback",
                style: AppTextStyles.SelectionTextStyle(
                    context, ColorManager.white, FontSize.f10)),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppPadding.p20),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.error,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s10),
                  ),
                  fixedSize: const Size(AppSize.s200, AppSize.s50),
                ),
                child: Text(
                  AppStrings.cancel,
                  style: AppTextStyles.SelectionTextStyle(
                      context, ColorManager.white, FontSize.f22),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: (viewModel.indexRate != 0) ? () {} : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.darkGreen,
                disabledBackgroundColor:
                    ColorManager.darkGreen.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s15),
                ),
                fixedSize: const Size(AppSize.s300, AppSize.s50),
              ),
              child: Text(
                AppStrings.confirm,
                style: AppTextStyles.SelectionTextStyle(
                    context, ColorManager.white, FontSize.f22),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class Back extends StatelessWidget {
  const Back({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding:
            const EdgeInsets.only(left: AppPadding.p20, top: AppPadding.p80),
        child: CircleAvatar(
          radius: AppSize.s18,
          backgroundColor: ColorManager.grey,
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.registerRoute);
            },
            padding: const EdgeInsets.only(left: AppPadding.p4),
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            color: ColorManager.white,
            iconSize: AppSize.s12,
          ),
        ),
      ),
    );
  }
}

SvgPicture star(bool ok) {
  if (ok) {
    return SvgPicture.asset(SVGAssets.fillStar);
  } else {
    return SvgPicture.asset(SVGAssets.emptyStar);
  }
}

class Rating extends StatelessWidget {
  const Rating({super.key, required this.viewModel});

  final RateViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 8),
          GestureDetector(
            onTap: () {
              viewModel.rated(1);
            },
            child: star(
              viewModel.changeRate(1),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              viewModel.rated(2);
            },
            child: star(
              viewModel.changeRate(2),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              viewModel.rated(3);
            },
            child: star(
              viewModel.changeRate(3),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              viewModel.rated(4);
            },
            child: star(
              viewModel.changeRate(4),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              viewModel.rated(5);
            },
            child: star(
              viewModel.changeRate(5),
            ),
          ),
          const Spacer(flex: 8),
        ],
      ),
    );
  }
}
