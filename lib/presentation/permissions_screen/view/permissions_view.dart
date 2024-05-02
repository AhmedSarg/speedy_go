import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/enums.dart';
import '../../base/base_states.dart';
import '../../base/cubit_builder.dart';
import '../../base/cubit_listener.dart';
import '../states/permissions_states.dart';
import '../viewmodel/permissions_viewmodel.dart';
import 'permissions_body.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => PermissionsViewModel()..start(),
        child: BlocConsumer<PermissionsViewModel, BaseStates>(
          listener: (context, state) {
            if (state is AllPermissionsGrantedState) {
              Navigator.pop(context);
            }
            baseListener(context, state);
          },
          builder: (context, state) {
            if (state is LocationPermissionsDisabledState) {
              return PermissionsBody(
                viewModel: PermissionsViewModel.get(context),
                locationError: LocationError.permissions,
              );
            }
            else if (state is LocationServiceDisabledState) {
              return PermissionsBody(
                viewModel: PermissionsViewModel.get(context),
                locationError: LocationError.services,
              );
            }
            return baseBuilder(
              context,
              state,
              PermissionsBody(
                viewModel: PermissionsViewModel.get(context),
                locationError: LocationError.services,
              ),
            );
          },
        ),
      ),
    );
  }
}
