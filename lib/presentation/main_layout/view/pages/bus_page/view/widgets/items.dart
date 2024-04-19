import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/bus_page/viewmodel/book_trip_viewmodel.dart';

import '../../../../../../buses_screen/view/widgets/text_field.dart';
import '../../../../../../common/validators/validators.dart';
import '../../../../../../resources/assets_manager.dart';
import '../../../../../../resources/color_manager.dart';
import '../../../../../../resources/font_manager.dart';
import '../../../../../../resources/strings_manager.dart';
import '../../../../../../resources/text_styles.dart';
import '../../../../../../resources/values_manager.dart';

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
  width: MediaQuery.of(context).size.width * .9,
  height: AppSize.s90,
  padding: const EdgeInsets.only(left: AppPadding.p20),
  margin: const EdgeInsets.symmetric(
      horizontal: AppPadding.p20, vertical: AppPadding.p12),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(AppSize.s20),
    color: ColorManager.lightBlack,
    border: Border.all(
        width: 1,
        color: errorContext.hasError
            ? ColorManager.error
            : ColorManager.black),
  ),
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
                  style: AppTextStyles.busesItemTripTitleTextStyle(context),
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

class dialogData extends StatelessWidget {
  const dialogData(
      {super.key,
      required this.tittle,
      this.onTap_1,
      this.onTap_2,
      this.onTap_3,
      this.onTap_4});
  final String tittle;
  final void Function()? onTap_1;
  final void Function()? onTap_2;
  final void Function()? onTap_3;
  final void Function()? onTap_4;

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
              SizedBox(
                width: AppSize.s5,
              ),
              Text(
                tittle,
                style: AppTextStyles.profileGeneralTextStyle(
                    context, FontSize.f20, ColorManager.lightBlue),
              ),
            ],
          ),
        ],
      ),
      actionsOverflowButtonSpacing: AppSize.s20,
      actions: [
        InkWell(
          onTap: onTap_1,
          child: Container(
            width: MediaQuery.of(context).size.width * .85,
            height: AppSize.s40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s10),
                color: ColorManager.darkBlack),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cairo',
                    style: AppTextStyles.profileGeneralTextStyle(
                        context, FontSize.f16, ColorManager.offwhite),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: AppSize.s24,
                    color: ColorManager.offwhite,
                  )
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: onTap_2,
          child: Container(
            width: MediaQuery.of(context).size.width * .85,
            height: AppSize.s40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s10),
                color: ColorManager.darkBlack),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ismailia',
                    style: AppTextStyles.profileGeneralTextStyle(
                        context, FontSize.f16, ColorManager.offwhite),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: AppSize.s24,
                    color: ColorManager.offwhite,
                  )
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: onTap_3,
          child: Container(
            width: MediaQuery.of(context).size.width * .85,
            height: AppSize.s40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s10),
                color: ColorManager.darkBlack),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sinai University',
                    style: AppTextStyles.profileGeneralTextStyle(
                        context, FontSize.f16, ColorManager.offwhite),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: AppSize.s24,
                    color: ColorManager.offwhite,
                  )
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: onTap_4,
          child: Container(
            width: MediaQuery.of(context).size.width * .85,
            height: AppSize.s40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s10),
                color: ColorManager.darkBlack),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Port Said',
                    style: AppTextStyles.profileGeneralTextStyle(
                        context, FontSize.f16, ColorManager.offwhite),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: AppSize.s24,
                    color: ColorManager.offwhite,
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: AppSize.s100,
        )
      ],
    );
  }
}
