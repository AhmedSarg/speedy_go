import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speedy_go/presentation/buses_screen/pages/add_trip_screen/view/widgets/trip_item.dart';
import 'package:speedy_go/presentation/common/widget/main_button.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/bus_page/viewmodel/book_trip_viewmodel.dart';
import '../../../../../../common/validators/validators.dart';
import '../../../../../../resources/assets_manager.dart';
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
            TripItem(
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
            TripItem(
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
            DateItem(
              viewModel: viewModel,
            ),
            const SizedBox(
              height: AppSize.s16,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .7,
              child: MainButton(
                text: 'Search',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    viewModel.searchTrip();
                  }
                },
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
