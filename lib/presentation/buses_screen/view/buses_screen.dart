import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/domain/usecase/add_bus_usecase.dart';
import 'package:speedy_go/presentation/buses_screen/pages/add_bus_screen/viewmodel/add_bus_viewmodel.dart';
import 'package:speedy_go/presentation/buses_screen/pages/drawer/view/drawer.dart';
import 'package:speedy_go/presentation/buses_screen/view/widgets/buses_screen_body.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

import '../../../app/sl.dart';

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
              icon: const Icon(
                Icons.menu,
                color: ColorManager.black,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: const DrawerBuse(),
      body: const BusesScreenBody(),
    );
  }
}
