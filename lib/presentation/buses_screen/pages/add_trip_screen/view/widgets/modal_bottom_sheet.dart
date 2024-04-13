import 'package:flutter/material.dart';

import '../../../../../resources/text_styles.dart';
import '../../../../../resources/values_manager.dart';

class ModelSheetItem extends StatelessWidget {
  const ModelSheetItem({super.key, this.onTap,  this.subTitle, required this.title, });
  final Function()? onTap;
  final String title;
  final String? subTitle;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p18),
        child:ListTile(
          title:  Text(
              title,
          ),
          subtitle:  Text(
              subTitle??"",
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}

class AppSettingItem extends StatelessWidget {
  const AppSettingItem({super.key, this.onTap, required this.text});
  final Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // const SizedBox(height: AppSize.s10,),
        const Divider(color: Colors.grey,)
      ],
    );

  }
}

