import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/trip_screen/view/pages/map_pages/view/pages/trip_map_body.dart';

import '../../../../../base/base_states.dart';
import '../../../../../base/cubit_builder.dart';
import '../../../../../base/cubit_listener.dart';
import '../../../../viewmodel/trip_viewmodel.dart';
import '../viewmodel/trip_map_viewmodel.dart';

class TripMapScreen extends StatelessWidget {
  const TripMapScreen({
    super.key,
    required this.viewModel,
  });

  final TripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TripMapViewModel, BaseStates>(
        listener: (context, state) {
          baseListener(context, state);
        },
        builder: (context, state) {
          return baseBuilder(
            context,
            state,
            TripMapBody(
              viewModel: TripMapViewModel.get(context),
            ),
          );
        },
      ),
    );
  }
}
