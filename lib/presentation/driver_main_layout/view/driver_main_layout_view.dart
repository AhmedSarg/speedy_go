import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/sl.dart';
import '../../base/base_states.dart';
import '../../base/cubit_builder.dart';
import '../../base/cubit_listener.dart';
import '../../buses_screen/states/buses_states.dart';
import '../../main_layout/states/main_states.dart';
import '../../resources/routes_manager.dart';
import '../viewmodel/driver_main_layout_viewmodel.dart';
import 'driver_main_layout_body.dart';

class DriverMainScreen extends StatelessWidget {
  const DriverMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => DriverMainViewModel(sl())..start(),
        child: BlocConsumer<DriverMainViewModel, BaseStates>(
          listener: (context, state) {
            if (state is CheckLocationPermissionsState) {
              Navigator.pushNamed(context, Routes.permissionsRoute).whenComplete(
                    () {
                      DriverMainViewModel.get(context).permissionsPermitted();
                },

              );
            }

            if (state is LogoutState) {
              Navigator.pop(context);

              Navigator.pushReplacementNamed(context, Routes.loginRoute);
            }
            baseListener(context, state);
          },
          builder: (context, state) {
            return baseBuilder(
              context,
              state,
              DriverMainScreenBody(viewModel: DriverMainViewModel.get(context)),
            );
          },
        ),
      ),
    );
  }
}
