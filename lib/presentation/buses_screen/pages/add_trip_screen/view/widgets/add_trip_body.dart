import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/presentation/buses_screen/pages/add_trip_screen/view/widgets/trip_item.dart';
import 'package:speedy_go/presentation/buses_screen/pages/add_trip_screen/view/widgets/trip_search.dart';
import 'package:speedy_go/presentation/buses_screen/view/widgets/buses_logo_widget.dart';
import 'package:speedy_go/presentation/common/widget/main_button.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

import '../../../../../common/validators/validators.dart';
import '../../../../../common/widget/options_menu.dart';
import '../../../../../resources/assets_manager.dart';
import '../../../../../resources/color_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/text_styles.dart';
import '../../../../view/widgets/buses_item.dart';
import '../../../../view/widgets/text_field.dart';
import '../../viewmodel/add_trip_viewmodel.dart';

class AddTripBody extends StatelessWidget {
  const AddTripBody({super.key, required this.viewModel});

  final AddTripViewModel viewModel;

  static final List<String> numTrips = [
    '1',
    '2',
  ];

  static String selectedValue = numTrips[0];

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print('-1');
    print(viewModel.getToSearchController);
    print(viewModel.getToController);
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),
            const BusesLogoWidget(),
            BusesItem(
              textStyle: AppTextStyles.busesSubItemTextStyle(context),
              imageIconColor: ColorManager.white.withOpacity(.8),
              imageIcon: SVGAssets.addTrip,
              title: AppStrings.busesAddTrip.tr(),
              backgroundColor: ColorManager.lightBlue,
            ),
            Row(
              children: [
                Expanded(
                    child: TripItem(
                  iconFunction: Center(
                    child: OptionMenu(
                      selectedValue: '',
                      color: ColorManager.lightBlue.withOpacity(.9),
                      Bgcolor: ColorManager.traditional,
                      items: numTrips
                          .map(
                            (e) => OptionMenuItem(
                              text: e,
                              onPressed: () {
                                viewModel.setNum = e;
                              },
                            ),
                          )
                          .toList(),
                      mainIcon: Icons.keyboard_arrow_down,
                    ),
                  ),
                  icon: Icons.add,
                  title: AppStrings.busesAddTripNum.tr(),
                  hintText: AppStrings.busesAddTripNumHint.tr(),
                  read: true,
                  validation: AppValidators.validateNotEmpty,
                  textInputType: TextInputType.number,
                  controller: viewModel.getNumController,
                )),
                Expanded(
                    child: TripItem(
                  title: AppStrings.busesAddTripPrice.tr(),
                  hintText: AppStrings.busesAddTripPriceHint.tr(),
                  inputFormatNumber: 6,
                  read: false,
                  validation: AppValidators.validateNotEmpty,
                  textInputType: TextInputType.phone,
                  controller: viewModel.getPriceController,
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: TripItem(
                  controller: viewModel.getFromController,
                  title: AppStrings.busesAddTripFrom.tr(),
                  hintText: AppStrings.busesAddTripFromHint.tr(),
                  read: true,
                  validation: AppValidators.validateNotEmpty,
                  textInputType: TextInputType.text,
                )),
                Expanded(
                  child: TripItem(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Container(
                              height: 1000,
                              width: MediaQuery.of(context).size.width * .8,
                              padding: const EdgeInsets.only(
                                top: AppPadding.p8,
                                right: AppPadding.p12,
                              ),
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(AppSize.s18),
                                      topLeft: Radius.circular(AppSize.s18)),
                                  color: ColorManager.darkGrey),
                              child: SearchFuncationalityState(
                                viewModel: viewModel,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    title: AppStrings.busesAddTripTo.tr(),
                    hintText: AppStrings.busesAddTripToHint.tr(),
                    read: true,
                    textInputType: TextInputType.text,
                    controller: viewModel.getToController,
                  ),
                ),
              ],
            ),
            Container(
              height: AppSize.s100,
              margin: const EdgeInsets.all(AppMargin.m5),
              padding: const EdgeInsets.all(AppPadding.p5),
              decoration: BoxDecoration(
                  color: ColorManager.offwhite,
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
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s16),
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
            ),
            const SizedBox(
              height: AppSize.s18,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              child: AppButton(
                bgColor: ColorManager.lightBlue,
                borderRadius: AppSize.s25,
                text: 'Add Trip',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print('_______________12______________________');
                  }
                },
              ),
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .5,
              child: AppButton(
                bgColor: ColorManager.red,
                text: 'Cancel',
                onPressed: () {
                  viewModel.getNumController.clear();
                  viewModel.getPriceController.clear();
                  viewModel.getToController.clear();
                  viewModel.getFromController.clear();
                  viewModel.getDateController.clear();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
