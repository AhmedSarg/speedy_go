import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/presentation/buses_screen/pages/add_trip_screen/view/widgets/trip_item.dart';
import 'package:speedy_go/presentation/buses_screen/pages/add_trip_screen/view/widgets/trip_search.dart';
import 'package:speedy_go/presentation/buses_screen/pages/add_trip_screen/view/widgets/trip_search_from.dart';
import 'package:speedy_go/presentation/buses_screen/view/widgets/buses_logo_widget.dart';
import 'package:speedy_go/presentation/common/widget/main_button.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

import '../../../../../common/validators/validators.dart';
import '../../../../../common/widget/options_menu.dart';
import '../../../../../resources/assets_manager.dart';
import '../../../../../resources/color_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/text_styles.dart';
import '../../../add_bus_screen/view/widgets/buses_item.dart';
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
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
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
                            child: SearchFuncationalityStateFrom(
                              viewModel: viewModel,
                            ),
                          ),
                        );
                      },
                    );
                  },
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
                    validation: AppValidators.validateNotEmpty,
                  ),
                ),
              ],
            ),
            FormField(
              validator: (_) {
                if (viewModel.getDateController.text.isEmpty) {
                  return AppStrings.validationsFieldRequired.tr();
                }
                return null;
              },
              builder: (errorContext) {
                return Container(
                  margin: const EdgeInsets.all(AppMargin.m5),
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
                                  style:
                                      AppTextStyles.busesItemTripTitleTextStyle(
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
                        onTap: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)),
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  datePickerTheme: DatePickerThemeData(
                                    shape: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s16),
                                    ),
                                  ),
                                  colorScheme:
                                      const ColorScheme.light().copyWith(
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
                          );
                          if (selectedDate != null) {
                            final selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (selectedTime != null) {
                              final combinedDateTime = DateTime(
                                selectedDate.year,
                                selectedDate.month,
                                selectedDate.day,
                                selectedTime.hour,
                                selectedTime.minute,
                              );
                              final formattedDateTime = DateFormat.yMd()
                                  .add_jm()
                                  .format(combinedDateTime);
                              DateTime parsedDateTime =
                                  DateFormat('dd/MM/yyyy HH:mm')
                                      .parse(formattedDateTime);
                              viewModel.setDate = parsedDateTime;
                            }
                          }
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
            ),
            const SizedBox(
              height: AppSize.s18,
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              child: MainButton(
                color: ColorManager.lightBlue,
                text: 'Add Trip',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    viewModel.addTrip();
                    viewModel.clear();

                  }
                },
              ),
            ),
            const SizedBox(
              height: AppSize.s18,
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width * .5,
              child: SecondButton(
                bgcolor: ColorManager.red,
                text: 'Cancel',
                onPressed: () {
                  viewModel.clear();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
