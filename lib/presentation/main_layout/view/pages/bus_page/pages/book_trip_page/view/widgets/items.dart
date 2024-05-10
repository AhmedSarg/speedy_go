import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../../buses_screen/view/widgets/text_field.dart';
import '../../../../../../../../common/validators/validators.dart';
import '../../../../../../../../resources/assets_manager.dart';
import '../../../../../../../../resources/color_manager.dart';
import '../../../../../../../../resources/font_manager.dart';
import '../../../../../../../../resources/strings_manager.dart';
import '../../../../../../../../resources/text_styles.dart';
import '../../../../../../../../resources/values_manager.dart';
import '../../viewmodel/book_trip_viewmodel.dart';

class DateItem extends StatelessWidget {
  const DateItem({super.key, required this.viewModel});

  final BookTripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: (_) {
        if (viewModel.getDateController.text.isEmpty) {
          return AppStrings.validationsFieldRequired.tr();
        }
        return null;
      },
      builder: (errorContext) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: AppMargin.m5),
          padding: const EdgeInsets.all(AppPadding.p5),
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: errorContext.hasError
                      ? ColorManager.error
                      : ColorManager.black),
              color: ColorManager.lightBlack,
              borderRadius: BorderRadius.circular(AppSize.s18)),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: AppPadding.p8, top: AppPadding.p5),
                      child: Row(children: [
                        Text(
                          AppStrings.busesAddDate.tr(),
                          style: AppTextStyles.busesItemTripTitleTextStyle(
                              context),
                        ),
                      ]),
                    ),
                    BusesTextField(
                      cursorColor: ColorManager.lightGrey,
                      readOnly: true,
                      validation: AppValidators.validateNotEmpty,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(20),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      hint: AppStrings.busesAddDateHint.tr(),
                      controller: viewModel.getDateController,
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    initialDate: DateTime.now(),
                    currentDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          datePickerTheme: DatePickerThemeData(
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSize.s16),
                            ),
                          ),
                          colorScheme: const ColorScheme.light().copyWith(
                            primary: ColorManager.lightBlue,
                            onPrimary: Colors.white,
                            surface: ColorManager.white,
                            onSurface: ColorManager.black,
                          ),
                          dialogBackgroundColor: Colors.white,
                        ),
                        child: child!,
                      );
                    },
                  ).then((selectedDate) {
                    if (selectedDate != null) {
                      print('Selected date: $selectedDate');
                      viewModel.setDate = selectedDate;
                    }
                  });
                },
                child: SvgPicture.asset(
                  SVGAssets.calender_2,
                  width: AppSize.s50,
                  colorFilter: const ColorFilter.mode(
                    ColorManager.lightBlue,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(
                width: AppSize.s18,
              )
            ],
          ),
        );
      },
    );
  }
}

final List<String> egyptGovernorates = [
  "الإسكندرية",
  "البحيرة",
  "الدقهلية",
  "دمياط",
  "الشرقية",
  "الغربية",
  "القليوبية",
  "المنوفية",
  "كفر الشيخ",
  "الأقصر",
  "أسوان",
  "الأسيوط",
  "البحر الأحمر",
  "المنيا",
  "سوهاج",
  "قنا",
  "جامعه سيناء",
  "شمال سيناء",
  "جنوب سيناء",
  "الوادي الجديد",
  "بورسعيد",
  "السويس",
  "القاهرة",
  "الجيزة",
];

class DialogData extends StatelessWidget {
  const DialogData({
    Key? key,
    required this.title,
    required this.controller,
  }) : super(key: key);

  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorManager.lightBlack,
      title: Row(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: ColorManager.grey,
                  )),
              const SizedBox(
                width: AppSize.s5,
              ),
              Text(
                title,
                style: AppTextStyles.profileGeneralTextStyle(
                    context, FontSize.f20, ColorManager.lightBlue),
              ),
            ],
          ),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: egyptGovernorates.length,
          itemBuilder: (BuildContext context, int index) {
            final governorate = egyptGovernorates[index];

            return Container(
              margin: const EdgeInsets.symmetric(vertical: AppMargin.m5),
              width: MediaQuery.of(context).size.width * .85,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s10),
                  color: ColorManager.darkBlack),
              child: ListTile(
                title: Text(
                  egyptGovernorates[index],
                  style: AppTextStyles.profileGeneralTextStyle(
                      context, FontSize.f16, ColorManager.offwhite),
                ),
                trailing: const Icon(
                  Icons.keyboard_arrow_down,
                  size: AppSize.s24,
                  color: ColorManager.offwhite,
                ),
                onTap: () {
                  controller.text = governorate;
                  Navigator.pop(context);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
