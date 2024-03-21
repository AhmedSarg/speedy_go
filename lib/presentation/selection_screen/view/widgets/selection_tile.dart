import 'package:flutter/material.dart';
import 'package:speedy_go/app/extensions.dart';

import '../../../../domain/models/enums.dart';
import '../../../common/data_intent/data_intent.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';

class SelectionTile extends StatefulWidget {
  const SelectionTile({
    super.key,
    required this.type,
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  final Selection type;
  final String title;
  final String imagePath;
  final Function() onTap;

  @override
  State<SelectionTile> createState() => _SelectionTileState();
}

class _SelectionTileState extends State<SelectionTile> {
  @override
  Widget build(BuildContext context) {
    Selection selection = DataIntent.getSelection();
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: AppSize.infinity,
        height: context.height() *
            (selection == widget.type
                ? .8
                : (selection == Selection.none ? .5 : .2)),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.imagePath),
            fit: BoxFit.cover,
          ),
          color: ColorManager.primary,
          border: Border(
            top: widget.type == Selection.passenger
                ? const BorderSide(
                    color: ColorManager.white,
                    width: AppSize.s2,
                  )
                : BorderSide.none,
            bottom: widget.type == Selection.driver
                ? const BorderSide(
                    color: ColorManager.white,
                    width: AppSize.s2,
                  )
                : BorderSide.none,
          ),
        ),
        child: Center(
          child: Text(
            widget.title,
            style: AppTextStyles.selectionScreenTileTextStyle(context),
          ),
        ),
      ),
    );
  }
}
