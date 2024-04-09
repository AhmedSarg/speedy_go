import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';
import 'package:speedy_go/presentation/trip_screen/view/widgets/trip_body.dart';

import '../../base/base_states.dart';
import '../../base/cubit_builder.dart';
import '../../base/cubit_listener.dart';
import '../viewmodel/trip_viewmodel.dart';

class TripScreen extends StatelessWidget {
  const TripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: AppSize.infinity,
        height: AppSize.infinity,
        child: BlocProvider(
          create: (context) => TripViewModel()..start(),
          child: BlocConsumer<TripViewModel, BaseStates>(
            listener: (context, state) {
              baseListener(context, state);
            },
            builder: (context, state) {
              return baseBuilder(context, state,
                  TripBody(viewModel: TripViewModel.get(context)));
            },
          ),
        ),
      ),
    );
  }
}