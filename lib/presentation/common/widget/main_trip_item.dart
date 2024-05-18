import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedy_go/domain/models/domain.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/text_styles.dart';
import '../../resources/values_manager.dart';

class MainTripItem extends StatelessWidget {
  const MainTripItem({
    super.key,
    required this.tripModel,
  });

  final TripBusModel tripModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p10),
      height: AppSize.s100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s12),
        color: ColorManager.veryLightGrey,
      ),
      child: ListTile(
        leading: SvgPicture.asset(
          SVGAssets.redBus,
          color: ColorManager.red,
        ),
        title: Text(
          DateFormat('hh:mm a').format(tripModel.date),
          style: AppTextStyles.profileGeneralTextStyle(
              context, FontSize.f16, ColorManager.lightBlue),
        ),
        subtitle: Text(
          '${tripModel.availableSeats} seats available',
          style: AppTextStyles.profileHintTextStyle(context),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          '${tripModel.price}.0 EGP',
          style: AppTextStyles.profileGeneralTextStyle(
            context,
            FontSize.f17,
            ColorManager.lightBlue,
          ),
        ),
      ),
    );
  }
}
