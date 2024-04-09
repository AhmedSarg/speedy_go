import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_go/presentation/trip_screen/viewmodel/trip_viewmodel.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import 'end_trip.dart';
import 'cancel_search.dart';
import 'cancel_trip.dart';
import 'confirm.dart';
import 'selection_trip.dart';
import 'edit_price.dart';

class TripBody extends StatelessWidget {
  const TripBody({super.key, required this.viewModel});

  final TripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Background(),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    EdgeInsets.only(left: AppPadding.p20, top: AppPadding.p80),
                child: Back(),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: AppSize.infinity,
                height:
                    (viewModel.indexPage == 4) ? AppSize.s650 : AppSize.s450,
                // height: ,
                decoration: const BoxDecoration(
                  color: ColorManager.lightBlack,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSize.s20),
                    topRight: Radius.circular(AppSize.s20),
                  ),
                ),
                // child: Selection(viewModel: viewModel,),
                // child: CancelTrip(viewModel: viewModel,),
                // child: CancelSearch(viewModel: viewModel,),
                // child: EditPrice(viewModel: viewModel),
                // child: Confirm(viewModel: viewModel),
                // child: EndTrip(viewModel: viewModel),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.infinity,
      width: AppSize.infinity,
      child: Image.asset(
        ImageAssets.loginBackgroundImage,
        fit: BoxFit.cover,
      ),
    );
  }
}

class Back extends StatelessWidget {
  const Back({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
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
    );
  }
}

class Item extends StatelessWidget {
  const Item(
      {super.key,
      required this.asset,
      required this.name,
      required this.color,
      required this.viewModel});

  final String asset, name;
  final Color color;
  final TripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        viewModel.selectionItem(asset == SVGAssets.car);
      },
      child: Container(
        width: AppSize.s170,
        height: AppSize.s160,
        padding: const EdgeInsets.all(AppPadding.p10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s20),
          border: Border.all(color: ColorManager.black),
          color: color,
        ),
        child: Column(
          children: [
            SvgPicture.asset(asset, height: AppSize.s100),
            Text(
              name.substring(9),
              style: AppTextStyles.SelectionTextStyle(
                  context, ColorManager.white, FontSize.f22),
            ),
          ],
        ),
      ),
    );
  }
}
