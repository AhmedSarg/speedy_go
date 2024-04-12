import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/base_states.dart';
import '../../base/cubit_builder.dart';
import '../../base/cubit_listener.dart';
import '../../resources/values_manager.dart';
import '../viewmodel/rate_viewmodel.dart';
import 'widgets/rate_body.dart';

class RateScreen extends StatelessWidget {
  const RateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: AppSize.infinity,
        height: AppSize.infinity,
        child: BlocProvider(
          create: (context) => RateViewModel()..start(),
          child: BlocConsumer<RateViewModel, BaseStates>(
            listener: (context, state) {
              baseListener(context, state);
            },
            builder: (context, state) {
              return baseBuilder(context, state,
                  RateBody(viewModel: RateViewModel.get(context)));
            },
          ),
        ),
      ),
    );
  }
}