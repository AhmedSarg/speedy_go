import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_go/presentation/resources/styles_manager.dart';

import '../../resources/color_manager.dart';
import '../../resources/text_styles.dart';
import '../../resources/values_manager.dart';

class OptionMenuItem {
  final SvgPicture? icon;
  final String text;
  final Function() onPressed;

  OptionMenuItem({
    this.icon,
    required this.text,
    required this.onPressed,
  });
}

class OptionMenu extends StatefulWidget {
  const OptionMenu({
    super.key,
    required this.items,
    required this.mainIcon,
    this.color,
    this.Bgcolor,
    this.selectedValue,
  });

  final IconData mainIcon;
  final Color? color;
  final Color? Bgcolor;
  final List<OptionMenuItem> items;
  final String? selectedValue;

  @override
  State<OptionMenu> createState() => _OptionMenuState();
}

class _OptionMenuState extends State<OptionMenu> {
  List<PopupMenuEntry> buildOptions(
    BuildContext context,
    List<OptionMenuItem> items,
  ) {
    List<PopupMenuEntry> list = [];
    for (OptionMenuItem item in items) {
      list.add(
        PopupMenuItem(
          onTap: item.onPressed,
          child: Row(
            children: [
              Text(
                item.text,
                style: AppTextStyles.optionsMenuOptionTextStyle(context),
              ),
            ],
          ),
        ),
      );
      list.add(
        const PopupMenuDivider(
          height: AppSize.s1,
        ),
      );
    }
    list.removeLast();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.items.isEmpty
          ? () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Center(
                    child: Text(
                      'You don\'t have any buses',
                      style: getRegularStyle(color: ColorManager.white),
                    ),
                  ),
                  backgroundColor: ColorManager.blueWithOpacity0_5,
                ),
              );
            }
          : null,
      child: PopupMenuButton(
        color: widget.Bgcolor ?? ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s10),
        ),
        enabled: widget.items.isNotEmpty,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.selectedValue!,
              style: AppTextStyles.optionsMenuOptionTextStyle(context),
            ),
            Icon(
              widget.mainIcon,
              color: widget.color ?? ColorManager.white,
            ),
          ],
        ),
        itemBuilder: (context) => buildOptions(context, widget.items),
      ),
    );
  }
}
