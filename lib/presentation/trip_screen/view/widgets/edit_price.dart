import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/trip_viewmodel.dart';

class EditPrice extends StatelessWidget {
  const EditPrice({super.key, required this.viewModel});

  final TripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel.pageChange(2);
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
        const Spacer(),
        SizedBox(
          width: AppSize.s350,
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
              // prefixIcon: const Icon(Icons.attach_money),
              prefixIconConstraints: const BoxConstraints(),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(AppPadding.p10),
                child: SvgPicture.asset(SVGAssets.cash),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s14),
                borderSide: const BorderSide(
                  color: Colors.lightBlue,
                  width: AppSize.s2,
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        Column(
          children: [
            const Divider(
              color: ColorManager.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    AppStrings.cancel,
                    style: AppTextStyles.SelectionTextStyle(
                        context, ColorManager.error, FontSize.f22),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    AppStrings.done,
                    style: AppTextStyles.SelectionTextStyle(
                        context, ColorManager.darkGreen, FontSize.f22),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
