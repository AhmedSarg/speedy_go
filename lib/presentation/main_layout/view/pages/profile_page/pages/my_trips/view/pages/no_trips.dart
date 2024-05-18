import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../../resources/assets_manager.dart';
import '../../../../../../../../resources/text_styles.dart';
import '../../../../../../../../resources/values_manager.dart';

class NoTrips extends StatelessWidget {
  const NoTrips({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(SVGAssets.pastTrip),
            const SizedBox(
              height: AppSize.s15,
            ),
            Text(
              'No Trips Found',
              style: AppTextStyles.profileItemTextStyle(context),
            ),
          ],
        ),
      ),
    );
  }
}
