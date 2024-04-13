import 'package:flutter/material.dart';
import 'package:speedy_go/presentation/buses_screen/view/widgets/buses_screen_body.dart';
import 'package:speedy_go/presentation/buses_screen/view/widgets/drawer_widget.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

class BusesScreen extends StatelessWidget {
  const BusesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      appBar: AppBar(
        backgroundColor: ColorManager.bgColor,
elevation: AppSize.s0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu,color: ColorManager.black,),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer:  const BusesDrawer(),
      body: const BusesScreenBody(),
    );
  }
}
