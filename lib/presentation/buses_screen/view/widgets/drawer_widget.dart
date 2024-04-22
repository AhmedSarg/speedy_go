import 'package:flutter/material.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

import '../../../resources/color_manager.dart';

class BusesDrawer extends StatelessWidget {
  const BusesDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: AppPadding.p8),
      height: context.height()*.8,
      child: Drawer(
backgroundColor: ColorManager.lightShadeOfGrey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update UI based on drawer item click
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update UI based on drawer item click
              },
            ),
            // Add more ListTile widgets for additional items
          ],
        ),
      ),
    );
  }
}
