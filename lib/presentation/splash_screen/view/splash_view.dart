import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/splash_screen/view/widgets/splash_body.dart';

import '../../../app/sl.dart';
import '../../base/base_states.dart';
import '../../base/cubit_builder.dart';
import '../../base/cubit_listener.dart';
import '../../resources/routes_manager.dart';
import '../viewmodel/splash_states.dart';
import '../viewmodel/splash_viewmodel.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashViewModel>(
      create: (_) => SplashViewModel(context, sl())..start(),
      child: BlocConsumer<SplashViewModel, BaseStates>(
        listener: (context, state) {
          if (state is UserNotSignedState) {
            Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
          } else if (state is UserSignedState) {
            Navigator.pushReplacementNamed(context, Routes.mainLayoutRoute);
          } else {
            baseListener(context, state);
          }
        },
        builder: (context, state) =>
            baseBuilder(context, state,  SplashBodyScreen(viewModel: SplashViewModel.get(context),)),
      ),
    );
  }

}
