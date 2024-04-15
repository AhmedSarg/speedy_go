import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_go/presentation/main_layout/viewmodel/main_viewmodel.dart';
import 'package:speedy_go/presentation/resources/assets_manager.dart';
import 'package:speedy_go/presentation/resources/text_styles.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';

class BookTripSearchPage extends StatelessWidget {
  const BookTripSearchPage({super.key, required this.viewModel});

  final MainViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Container(
        color: ColorManager.lightGrey,
        child: Column(
          children: [
            const BackgroundImg(),
            Item(
              viewModel: viewModel,
              title: AppStrings.bookTripSearchScreenFromItem.tr(),
              subTitle: AppStrings.bookTripSearchScreenSubTitleFromItem.tr(),
              isDate: false,
            ),
            Item(
              viewModel: viewModel,
              title: AppStrings.bookTripSearchScreenToItem.tr(),
              subTitle: AppStrings.bookTripSearchScreenSubTitleToItem.tr(),
              isDate: false,
            ),
            Item(
              viewModel: viewModel,
              title: AppStrings.bookTripSearchScreenDateItem.tr(),
              subTitle: AppStrings.bookTripSearchScreenSubTitleDateItem.tr(),
              isDate: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p20),
              child: Container(
                width: AppSize.infinity,
                height: height / 18,
                margin: const EdgeInsets.symmetric(horizontal: AppMargin.m64),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.traditional,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s30),
                    ),
                  ),
                  child: Text(
                    AppStrings.bookTripSearchScreenButtonItem.tr(),
                    style: AppTextStyles.bookTripSearchScreenButtonItemTextStyle(
                        context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BackgroundImg extends StatelessWidget {
  const BackgroundImg({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding:
          const EdgeInsets.only(top: AppPadding.p30, bottom: AppPadding.p20),
      child: Container(
        height: height / 4,
        width: AppSize.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImageAssets.bookTripBackgroundImage),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Text(
            AppStrings.bookTripSearchScreenTitle.tr(),
            style: AppTextStyles.bookTripSearchScreenTitleTextStyle(context),
          ),
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  const Item(
      {super.key,
      required this.viewModel,
      required this.title,
      required this.isDate,
      required this.subTitle});

  final MainViewModel viewModel;
  final String title;
  final String subTitle;
  final bool isDate;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
      child: GestureDetector(
        onTap: () {
          isDate
              ? showDatePicker(  //Not Finished UI
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2025),
                )
              : showDialog(
                  context: context,
                  builder: (context) => Dialog(title: title),
                );
        },
        child: Container(
          width: width / 1.1,
          height: height / 9,
          padding: const EdgeInsets.only(left: AppPadding.p20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s20),
            color: ColorManager.lightBlack,
            border: Border.all(color: ColorManager.black),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppPadding.p10),
                    child: Text(
                      title,
                      style:
                          AppTextStyles.bookTripSearchScreenTitleItemTextStyle(
                              context),
                    ),
                  ),
                  Text(
                    subTitle,
                    style:
                        AppTextStyles.bookTripSearchScreenSubTitleItemTextStyle(
                            context),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p60),
                child: isDate
                    ? SvgPicture.asset(SVGAssets.date)
                    : const SizedBox(width: AppSize.s60),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Dialog extends StatelessWidget {
  const Dialog({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: AppTextStyles.bookTripSearchScreenTitleDialogTextStyle(context),
      ),
    );
  }
}
