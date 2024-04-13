import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    required this.mainIcon, this.color, this.Bgcolor, this.selectedValue,

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

          onTap: () {
            setState(() {
              selectedValue = item.text;
            });
            item.onPressed();
          },
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

  late String selectedValue = widget.items[0].text;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: widget.Bgcolor ?? ColorManager.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
            Text(
              widget.selectedValue ?? selectedValue,
              style: AppTextStyles.optionsMenuOptionTextStyle(context),
            ),
          Icon(
            widget.mainIcon,
            color: widget.color ?? ColorManager.white,
          ),
        ],
      ),
      itemBuilder: (context) => buildOptions(context, widget.items),
    );
  }
}
