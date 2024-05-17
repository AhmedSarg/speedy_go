import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/base/base_states.dart';
import 'package:speedy_go/presentation/base/cubit_builder.dart';
import 'package:speedy_go/presentation/base/cubit_listener.dart';
import 'package:speedy_go/presentation/buses_screen/states/buses_states.dart';
import 'package:speedy_go/presentation/buses_screen/viewmodel/buses_viewmodel.dart';
import 'package:speedy_go/presentation/resources/routes_manager.dart';

import '../../../app/sl.dart';
import '../../common/widget/main_drawer.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';
import 'widgets/buses_screen_body.dart';

class BusesScreen extends StatelessWidget {
  const BusesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => BusesViewModel(sl())..start(),
        child: BlocConsumer<BusesViewModel, BaseStates>(
          listener: (context, state) {
            if (state is LogoutState) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.loginRoute,
                ModalRoute.withName('/'),
              );
            }
            baseListener(context, state);
          },
          builder: (context, state) {
            return baseBuilder(context, state, buildContent(context));
          },
        ),
      ),
    );
  }

  buildContent(BuildContext context) {
    BusesViewModel viewModel = BusesViewModel.get(context);
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
      drawer: MainDrawer(
        name: viewModel.getName,
        start: viewModel.start,
        logOut: viewModel.logout,
        imagePath: viewModel.getImagePath,
      ),
      body: const BusesScreenBody(),
    );
  }
}
