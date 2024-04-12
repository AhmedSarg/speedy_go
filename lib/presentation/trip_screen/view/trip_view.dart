import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/resources/routes_manager.dart';
import 'package:speedy_go/presentation/trip_screen/view/states/trip_states.dart';

import '../../base/base_states.dart';
import '../../base/cubit_builder.dart';
import '../../base/cubit_listener.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';
import '../viewmodel/trip_viewmodel.dart';
import 'widgets/trip_body.dart';

class TripScreen extends StatelessWidget {
  const TripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: SizedBox(
            height: AppSize.infinity,
            width: AppSize.infinity,
            child: Image.asset(
              ImageAssets.loginBackgroundImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: ColorManager.transparent,
          body: SizedBox(
            width: AppSize.infinity,
            height: AppSize.infinity,
            child: SafeArea(
              child: BlocProvider(
                create: (context) => TripViewModel()..start(),
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
                      TripBody(viewModel: TripViewModel.get(context)),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
