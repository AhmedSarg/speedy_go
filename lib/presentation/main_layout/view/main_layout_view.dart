import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/enums.dart';
import '../../base/base_states.dart';
import '../../base/cubit_builder.dart';
import '../../base/cubit_listener.dart';
import '../states/main_states.dart';
import '../viewmodel/main_viewmodel.dart';
import 'main_layout_body.dart';
import 'pages/permissions_page/view/main_permissions_view.dart';

class MainLayoutScreen extends StatelessWidget {
  const MainLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => MainViewModel()..start(),
        child: BlocConsumer<MainViewModel, BaseStates>(
          listener: (context, state) {
            baseListener(context, state);
          },
          builder: (context, state) {
            print(state);
            MainViewModel viewModel =
            MainViewModel.get(context);
            if (state is LocationServiceDisabledState) {
              return MainPermissionsPage(
                locationError: LocationError.services,
                viewModel: viewModel,
              );
            } else if (state is LocationPermissionsDisabledState) {
              return MainPermissionsPage(
                locationError: LocationError.permissions,
                viewModel: viewModel,
              );
            }
            return baseBuilder(
              context,
              state,
              MainLayoutBody(viewModel: MainViewModel.get(context)),
            );
          },
        ),
      ),
    );
  }
}
