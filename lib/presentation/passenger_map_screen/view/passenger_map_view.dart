import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/enums.dart';
import '../../base/base_states.dart';
import '../../base/cubit_builder.dart';
import '../../base/cubit_listener.dart';
import '../../resources/values_manager.dart';
import '../states/passenger_map_states.dart';
import '../viewmodel/passenger_map_viewmodel.dart';
import 'pages/passenger_map_body.dart';
import 'pages/passenger_map_location.dart';
import 'pages/passenger_map_permissions.dart';

class PassengerMapScreen extends StatelessWidget {
  const PassengerMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: AppSize.infinity,
        height: AppSize.infinity,
        child: BlocProvider(
          create: (context) => PassengerMapViewModel()..start(),
          child: BlocConsumer<PassengerMapViewModel, BaseStates>(
            listener: (context, state) {
              baseListener(context, state);
            },
            builder: (context, state) {
              PassengerMapViewModel viewModel =
                  PassengerMapViewModel.get(context);
              if (state is LocationServiceDisabledState) {
                return PassengerMapPermissions(
                  locationError: LocationError.services,
                  viewModel: viewModel,
                );
              } else if (state is LocationPermissionsDisabledState) {
                return PassengerMapPermissions(
                  locationError: LocationError.permissions,
                  viewModel: viewModel,
                );
              } else if (state is LocationMapState) {
                return PassengerMapLocation(
                  locationMapType: state.locationMapType,
                );
              }
              return baseBuilder(context, state, const PassengerMapBody());
            },
          ),
        ),
      ),
    );
  }
}
