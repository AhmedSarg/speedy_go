import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/base_states.dart';
import '../../base/cubit_builder.dart';
import '../../base/cubit_listener.dart';
import '../viewmodel/driver_trip_viewmodel.dart';
import 'driver_trip_body.dart';

class DriverTripScreen extends StatelessWidget {
  const DriverTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => DriverTripViewModel()..start(),
        child: BlocConsumer<DriverTripViewModel, BaseStates>(
          listener: (context, state) {
            baseListener(context, state);
          },
          builder: (context, state) {
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
