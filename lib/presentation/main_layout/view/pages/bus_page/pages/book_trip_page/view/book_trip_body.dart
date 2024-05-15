import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../../../buses_screen/view/pages/add_trip_screen/view/widgets/trip_item.dart';
import '../../../../../../../common/validators/validators.dart';
import '../../../../../../../common/widget/main_button.dart';
import '../../../../../../../resources/assets_manager.dart';
import '../../../../../../../resources/strings_manager.dart';
import '../../../../../../../resources/text_styles.dart';
import '../../../../../../../resources/values_manager.dart';
import '../viewmodel/book_trip_viewmodel.dart';
import 'widgets/items.dart';

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: TripItem(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DialogData(
                          title: 'From',
                          controller: viewModel.getFromController,
                        );
                      },
                    );
                  },
                  title: 'From',
                  hintText: 'choose trip destination ',
                  read: true,
                  validation: AppValidators.validateNotEmpty,
                  textInputType: TextInputType.text,
                  controller: viewModel.getFromController),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: TripItem(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DialogData(
                          title: 'To',
                          controller: viewModel.getToController,
                        );
                      },
                    );
                  },
                  title: 'To',
                  hintText: 'choose trip start location',
                  read: true,
                  validation: AppValidators.validateNotEmpty,
                  textInputType: TextInputType.text,
                  controller: viewModel.getToController),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: DateItem(
                viewModel: viewModel
              ),
            ),
            const SizedBox(
              height: AppSize.s30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .7,
              child: MainButton(
                text: 'Search',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    viewModel.findTrip();
                  }
                },
              ),
            ),
            const SizedBox(
              height: AppSize.s30,
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
