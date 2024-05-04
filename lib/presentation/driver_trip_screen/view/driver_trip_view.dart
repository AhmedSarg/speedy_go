import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

import '../../../app/sl.dart';
import '../../base/base_states.dart';
import '../../base/cubit_builder.dart';
import '../../base/cubit_listener.dart';
import '../../resources/routes_manager.dart';
import '../states/driver_trip_states.dart';
import '../viewmodel/driver_trip_viewmodel.dart';
import 'driver_trip_body.dart';
import 'widgets/status_dialog.dart';

class DriverTripScreen extends StatelessWidget {
  const DriverTripScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => DriverTripViewModel(sl(), sl(), sl(), sl(), sl())..start(),
          child: BlocConsumer<DriverTripViewModel, BaseStates>(
            listener: (context, state) {
              if (state is RatePassengerState) {
                Navigator.pushNamed(context, Routes.rateRoute);
              } else if (state is ChangeDriverStatusState) {
                showDialog(
                  context: context,
                  builder: (_) => StatusDialog(
                    viewModel: DriverTripViewModel.get(context),
                  ),
                );
              } else if (state is DriverStatusChangedState) {
                Navigator.pop(context);
              } else if (state is CheckPermissionsState) {
                Navigator.pushNamed(context, Routes.permissionsRoute)
                    .whenComplete(
                  () async {
                    await DriverTripViewModel.get(context)
                        .toggleDriverStatusRemote();
                  },
                );
              }
              baseListener(context, state);
            },
            builder: (context, state) {
              print(state);
              return baseBuilder(
                context,
                state,
                DriverTripBody(
                  viewModel: DriverTripViewModel.get(context),
                ),
              );
            },
          ),
        ),
    );
  }
}
