import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../resources/values_manager.dart';

class BusesItem extends StatelessWidget {
  const BusesItem({super.key, required this.imageIcon, required this.title, this.onTap, required this.backgroundColor, required this.imageIconColor, this.textStyle});
  final String imageIcon;
  final Color imageIconColor;
  final String title;
  final TextStyle? textStyle;
  final Color backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
        width: MediaQuery.of(context).size.width*.80,
        height: AppSize.s100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s10),
            color: backgroundColor
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
           SvgPicture.asset(imageIcon,
               colorFilter: ColorFilter.mode(imageIconColor, BlendMode.srcIn),
           ),
            Text(title,style:textStyle,)

          ],
        ),
      ),
    );
  }
}
