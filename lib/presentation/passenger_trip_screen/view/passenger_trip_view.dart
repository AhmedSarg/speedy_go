import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/sl.dart';
import '../../base/base_states.dart';
import '../../base/cubit_builder.dart';
import '../../base/cubit_listener.dart';
import '../../resources/routes_manager.dart';
import '../states/trip_states.dart';
import '../viewmodel/passenger_trip_viewmodel.dart';
import 'passenger_trip_body.dart';

class PassengerTripScreen extends StatelessWidget {
  const PassengerTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PassengerTripViewModel(sl(), sl(), sl(), sl(), sl())..start(),
      child: BlocConsumer<PassengerTripViewModel, BaseStates>(
        listener: (context, state) {
          if (state is RateDriverState) {
            // Navigator.pushReplacementNamed(context, Routes.rateRoute);
            Navigator.pushNamed(
              context,
              Routes.rateRoute,
            ).then(
              (v) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.mainLayoutRoute,
                  (route) => false,
                );
              },
            );
          }
          baseListener(context, state);
        },
        builder: (context, state) {
          return baseBuilder(
            context,
            state,
            PassengerTripBody(viewModel: PassengerTripViewModel.get(context)),
          );
        },
      ),
    );
  }
}
