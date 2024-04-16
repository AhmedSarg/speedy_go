import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_go/presentation/resources/assets_manager.dart';
import 'package:speedy_go/presentation/resources/text_styles.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

import '../../../../../../../../resources/color_manager.dart';

class MyPastTrip extends StatelessWidget {
  const MyPastTrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: ColorManager.bgColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
SvgPicture.asset(SVGAssets.pastTrip),
            const SizedBox(height: AppSize.s15,),
            Text('No trips found',style: AppTextStyles.profileItemTextStyle(context),)

          ],
        ),
      ),
    )
    ;
  }
}
