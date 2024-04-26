import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/rating_screen/states/rate_states.dart';
import 'package:speedy_go/presentation/resources/routes_manager.dart';

import '../../../app/sl.dart';
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
      body: PopScope(
        canPop: false,
        child: SizedBox(
          width: AppSize.infinity,
          height: AppSize.infinity,
          child: BlocProvider(
            create: (context) => RateViewModel(sl())..start(),
            child: BlocConsumer<RateViewModel, BaseStates>(
              listener: (context, state) {
                if (state is RateSuccessState) {
                  Navigator.pushReplacementNamed(
                    context,
                    Routes.mainLayoutRoute,
                  );
                }
                baseListener(context, state);
              },
              builder: (context, state) {
                return baseBuilder(
                  context,
                  state,
                  RateBody(
                    viewModel: RateViewModel.get(context),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
