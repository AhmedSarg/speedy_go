import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../base/base_states.dart';
import '../../../../../base/cubit_builder.dart';
import '../../../../../base/cubit_listener.dart';
import '../../../../../resources/routes_manager.dart';
import '../../../../states/driver_trip_states.dart';
import '../viewmodel/driver_trip_page_viewmodel.dart';
import 'driver_trip_page_body.dart';
import 'widgets/status_dialog.dart';

class DriverTripScreen extends StatelessWidget {
  const DriverTripScreen({super.key, required this.onChange});

  final Function() onChange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DriverTripViewModel, BaseStates>(
        listener: (context, state) {
          DriverTripViewModel viewModel = DriverTripViewModel.get(context);
          if (state is RatePassengerState) {
            Navigator.pushNamed(context, Routes.rateRoute).whenComplete(() {
              viewModel.afterTrip();
            });
          } else if (state is ChangeDriverStatusState) {
            showDialog(
              context: context,
              builder: (_) => StatusDialog(
                viewModel: DriverTripViewModel.get(context),
              ),
            );
          } else if (state is DriverStatusChangedState) {
            Navigator.pop(context);
            onChange();
          } else if (state is CheckPermissionsState) {
            Navigator.pushNamed(context, Routes.permissionsRoute).whenComplete(
              () async {
                await DriverTripViewModel.get(context)
                    .onLocationPermissionsSuccess();
              },
            );
          }
          baseListener(context, state);
        },
        builder: (context, state) {
          if (state is CheckPermissionsState) {
            state = LoadingState();
          }
          return baseBuilder(
            context,
            state,
            DriverTripBody(
              viewModel: DriverTripViewModel.get(context),
            ),
          );
        },
      ),
    );
  }
}
