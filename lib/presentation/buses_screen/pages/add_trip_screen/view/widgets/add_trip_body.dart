import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/presentation/buses_screen/pages/add_trip_screen/view/widgets/trip_item.dart';
import 'package:speedy_go/presentation/buses_screen/view/widgets/buses_logo_widget.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

import '../../../../../common/widget/options_menu.dart';
import '../../../../../resources/assets_manager.dart';
import '../../../../../resources/color_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/text_styles.dart';
import '../../../../view/widgets/buses_item.dart';
import '../../../../view/widgets/text_field.dart';
import '../../viewmodel/add_trip_viewmodel.dart';
import 'modal_bottom_sheet.dart';

class AddTripBody extends StatefulWidget {
  const AddTripBody({super.key, required this.viewModel});
  final AddTripViewModel viewModel;

  @override
  State<AddTripBody> createState() => _AddTripBodyState();
}

class _AddTripBodyState extends State<AddTripBody> {
  final List<String> numTrips = [
    '1',
    '2',
  ];
  late String selectedValue = numTrips[0];

  @override
  Widget build(BuildContext context) {
    return Column(
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
              IconFunction: Center(
                child: OptionMenu(
                  selectedValue: '',
                  color: ColorManager.lightBlue.withOpacity(.9),
                  Bgcolor: ColorManager.traditional,
                  items: numTrips
                      .map(
                        (e) => OptionMenuItem(
                          text: e,
                          onPressed: () {
                            widget.viewModel.setNum(e);
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
              textInputType: TextInputType.number,
              controller: widget.viewModel.getNumController,
            )),
            Expanded(
                child: TripItem(
              title: AppStrings.busesAddTripPrice.tr(),
              hintText: AppStrings.busesAddTripPriceHint.tr(),
              inputFormatNumber: 6,
              read: false,
              textInputType: TextInputType.phone,
              controller: widget.viewModel.getPriceController,
            )),
          ],
        ),
        Row(
          children: [
            Expanded(
                child: TripItem(
              title: AppStrings.busesAddTripFrom.tr(),
              hintText: AppStrings.busesAddTripFromHint.tr(),
              read: true,
              textInputType: TextInputType.number,
            )),
            Expanded(
                child: TripItem(
              title: AppStrings.busesAddTripTo.tr(),
              hintText: AppStrings.busesAddTripToHint.tr(),
              read: true,
              textInputType: TextInputType.number,
            )),
          ],
        ),
      ],
    );
  }
}