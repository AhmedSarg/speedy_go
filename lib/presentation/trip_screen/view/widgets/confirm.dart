import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/trip_viewmodel.dart';

class Confirm extends StatelessWidget {
  const Confirm({super.key, required this.viewModel});

  final TripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel.pageChange(4);
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
        Card(viewModel: viewModel, i: 1),
        Card(viewModel: viewModel, i: 2),
        Card(viewModel: viewModel, i: 3),
        ElevatedButton(
          onPressed: (viewModel.selectedCard != -1)
              ? () {}
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
  const Card({super.key, required this.viewModel, required this.i});

  final TripViewModel viewModel;
  final int i;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        viewModel.selectionCard(i);
      },
      child: Container(
        width: AppSize.s350,
        height: AppSize.s160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s35),
          color: viewModel.colorCardChange(i),
          border: Border.all(color: ColorManager.black),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(AppPadding.p10),
                  child: CircleAvatar(
                    radius: 40,
                    // child: ,
                  ),
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: AppPadding.p50, bottom: AppPadding.p2),
                          child: Text(
                            "Mohamed",
                            style: AppTextStyles.SelectionTextStyle(context,
                                viewModel.textColorCardChange(i), FontSize.f12),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              SVGAssets.location,
                              height: AppSize.s15,
                            ),
                            Text(
                              "east qantra hospital",
                              style: AppTextStyles.SelectionTextStyle(
                                  context,
                                  viewModel.textColorCardChange(i),
                                  FontSize.f12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppPadding.p14),
                      child: Text(
                        "EGP 50, cash",
                        style: AppTextStyles.SelectionTextStyle(context,
                            viewModel.textColorCardChange(i), FontSize.f12),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Toyota Corolla",
                      style: AppTextStyles.SelectionTextStyle(context,
                          viewModel.textColorCardChange(i), FontSize.f12),
                    ),
                    Text(
                      "ج ي س 143",
                      style: AppTextStyles.SelectionTextStyle(context,
                          viewModel.textColorCardChange(i), FontSize.f12),
                    ),
                  ],
                ),
                Text(
                  "Color: white",
                  style: AppTextStyles.SelectionTextStyle(
                      context, viewModel.textColorCardChange(i), FontSize.f12),
                ),
                Row(
                  children: [
                    Text(
                      "4",
                      style: AppTextStyles.SelectionTextStyle(context,
                          viewModel.textColorCardChange(i), FontSize.f12),
                    ),
                    SvgPicture.asset(SVGAssets.star, height: AppSize.s10),
                  ],
                ),
              ],
            ),
            Text(
              "Will arrive in 10 min.",
              style: AppTextStyles.SelectionTextStyle(
                  context, viewModel.textColorCardChange(i), FontSize.f12),
            ),
          ],
        ),
      ),
    );
  }
}
