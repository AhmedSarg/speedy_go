import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/trip_viewmodel.dart';

class TripPrice extends StatelessWidget {
  const TripPrice({super.key});

  static late TripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = TripViewModel.get(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: AppPadding.p20),
          child: Column(
            children: [
              Text(
                "EGP ${viewModel.price.toString()}",
                style: AppTextStyles.SelectionTextStyle(
                    context, ColorManager.black, FontSize.f22),
              ),
              const Divider(
                color: ColorManager.black,
                indent: AppSize.s20,
                endIndent: AppSize.s20,
              ),
              Text(
                "Recommended fare, adjustable",
                style: AppTextStyles.SelectionTextStyle(
                    context, ColorManager.black, FontSize.f16),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p40, vertical: AppPadding.p30),
          child: TextField(
            controller: viewModel.newPrice,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: ColorManager.white),
            decoration: InputDecoration(
              fillColor: ColorManager.darkShadeOfGrey,
              filled: true,
              hintText: "Cash",
              hintStyle: const TextStyle(color: ColorManager.white),
              hoverColor: ColorManager.lightBlue,
              prefixIconConstraints: const BoxConstraints(),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(AppPadding.p10),
                child: SvgPicture.asset(SVGAssets.cash),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s14),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s14),
                borderSide: const BorderSide(
                  color: ColorManager.secondary,
                  width: AppSize.s1,
                ),
              ),
            ),
          ),
        ),
        Column(
          children: [
            const Divider(color: ColorManager.black),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      viewModel.prevPage();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.error,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s10),
                      ),
                    ),
                    child: Text(
                      'Back',
                      style: AppTextStyles.SelectionTextStyle(
                          context, ColorManager.white, FontSize.f22),
                    ),
                  ),
                ),
                const SizedBox(width: AppSize.s10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      viewModel.nextPage();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s10),
                      ),
                    ),
                    child: Text(
                      'Next',
                      style: AppTextStyles.SelectionTextStyle(
                          context, ColorManager.white, FontSize.f22),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
