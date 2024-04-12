import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/trip_screen/view/pages/map_pages/viewmodel/trip_map_viewmodel.dart';

import '../../base/base_states.dart';
import '../../base/cubit_builder.dart';
import '../../base/cubit_listener.dart';
import '../../resources/routes_manager.dart';
import '../states/trip_states.dart';
import '../viewmodel/trip_viewmodel.dart';
import 'pages/details_pages/trip_details_body.dart';
import 'pages/map_pages/view/trip_map_view.dart';

class TripScreen extends StatelessWidget {
  const TripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TripViewModel>(
          create: (context) => TripViewModel()..start(),
        ),
        BlocProvider<TripMapViewModel>(
          create: (context) => TripMapViewModel()..start(),
        ),
      ],
      child: BlocConsumer<TripViewModel, BaseStates>(
        listener: (context, state) {
          if (state is RateDriverState) {
            Navigator.pushNamed(context, Routes.rateRoute);
          }
          baseListener(context, state);
        },
        builder: (context, state) {
          return baseBuilder(
            context,
            state,
            TripMapScreen(viewModel: TripViewModel.get(context)),
          );
        },
      ),
    );
  }
}
