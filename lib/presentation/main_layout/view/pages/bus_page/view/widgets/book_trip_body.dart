import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:speedy_go/presentation/buses_screen/pages/add_trip_screen/view/widgets/trip_item.dart';
import 'package:speedy_go/presentation/common/widget/main_button.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/bus_page/viewmodel/book_trip_viewmodel.dart';
import '../../../../../../buses_screen/view/widgets/text_field.dart';
import '../../../../../../common/validators/validators.dart';
import '../../../../../../resources/assets_manager.dart';
import '../../../../../../resources/color_manager.dart';
import '../../../../../../resources/font_manager.dart';
import '../../../../../../resources/strings_manager.dart';
import '../../../../../../resources/text_styles.dart';
import '../../../../../../resources/values_manager.dart';
import 'items.dart';

class BookTripsBody extends StatelessWidget {
  const BookTripsBody({super.key, required this.viewModel});
  final BookTripViewModel viewModel;
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const BackgroundImg(),
            FormField(
              validator: (_) {
                if (viewModel.getFromController.text.isEmpty) {
                  return AppStrings.validationsFieldRequired.tr();
                }
                return null;
              },
              builder: (errorContext) {
                return  Container(
                  margin: const EdgeInsets.symmetric(horizontal: AppMargin.m16),
                  height: AppSize.s90,
                  width: MediaQuery.of(context).size.width*.9,

                  decoration: BoxDecoration(
                      color: ColorManager.lightBlack,

                      border: Border.all(
                          width: 1,
                          color: errorContext.hasError
                              ? ColorManager.error
                              : ColorManager.black),
                      borderRadius: BorderRadius.circular(AppSize.s18)),
                  child: TripItem(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return dialogData(
                                tittle: 'To',
                                onTap_1: () {
                                  viewModel.getFromController.text = 'Cairo';
                                  Navigator.pop(context);
                                },
                                onTap_2: () {
                                  viewModel.getFromController.text = 'Ismailia';
                                  Navigator.pop(context);
                                },
                                onTap_3: () {
                                  viewModel.getFromController.text =
                                  'Sinai University';
                                  Navigator.pop(context);
                                },
                                onTap_4: () {
                                  viewModel.getFromController.text = 'Port Said';
                                  Navigator.pop(context);
                                });
                          },
                        );
                      },
                      title: 'From',
                      hintText: 'choose trip start location',
                      read: true,
                      validation: AppValidators.validateNotEmpty,
                      textInputType: TextInputType.text,
                      controller: viewModel.getFromController),
                );
              },
            ),
            FormField(
              validator: (_) {
                if (viewModel.getToController.text.isEmpty) {
                  return AppStrings.validationsFieldRequired.tr();
                }
                return null;
              },

              builder: (errorContext) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: AppMargin.m16,vertical: AppMargin.m16),
                  height: AppSize.s90,
                  width: MediaQuery.of(context).size.width*.9,

                  decoration: BoxDecoration(
                      color: ColorManager.lightBlack,

                      border: Border.all(
                          width: 1,
                          color: errorContext.hasError
                              ? ColorManager.error
                              : ColorManager.black),
                      borderRadius: BorderRadius.circular(AppSize.s18)),
                  child: TripItem(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return dialogData(
                                tittle: 'To',
                                onTap_1: () {
                                  viewModel.getToController.text = 'Cairo';
                                  Navigator.pop(context);
                                },
                                onTap_2: () {
                                  viewModel.getToController.text = 'Ismailia';
                                  Navigator.pop(context);
                                },
                                onTap_3: () {
                                  viewModel.getToController.text = 'Sinai University';
                                  Navigator.pop(context);
                                },
                                onTap_4: () {
                                  viewModel.getToController.text = 'Port Said';
                                  Navigator.pop(context);
                                });
                            ;
                          },
                        );
                      },
                      title: 'To',
                      hintText: 'choose trip destination ',
                      read: true,
                      validation: AppValidators.validateNotEmpty,

                      textInputType: TextInputType.text,
                      controller: viewModel.getToController),
                );
              },
            ),
            DateItem(
              viewModel: viewModel,
            ),
        const SizedBox(height: AppSize.s16,),
            SizedBox(
              width: MediaQuery.of(context).size.width*.7,
              child: MainButton(text: 'Search', onPressed: () {
                if (_formKey.currentState!.validate()) {
                  viewModel.searchTrip();
                }

              },),
            )
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
