import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/sl.dart';
import '../../base/base_states.dart';
import '../../base/cubit_builder.dart';
import '../../base/cubit_listener.dart';
import '../../resources/routes_manager.dart';
import '../states/login_states.dart';
import '../viewmodel/login_viewmodel.dart';
import 'widgets/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginViewModel(sl(), sl())..start(),
        child: BlocConsumer<LoginViewModel, BaseStates>(
          listener: (context, state) {
            if (state is UserIsPassengerState) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.mainLayoutRoute,
                ModalRoute.withName('/'),
              );
            } else if (state is UserIsDriverState) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.driverMainLayoutRoute,
                ModalRoute.withName('/'),
              );
            } else if (state is UserIsBusDriverState) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.busesRoute,
                ModalRoute.withName('/'),
              );
            } else if (state is ErrorState) {
              Navigator.pop(context);
            }
            else if (state is LoginVerifyPhoneNumberState) {
              Navigator.pushNamed(context, Routes.verificationRoute);
            }
            baseListener(context, state);
          },
          builder: (context, state) {
            return baseBuilder(
              context,
              state,
              LoginBody(
                viewModel: LoginViewModel.get(context),
              ),
            );
          },
        ),
      ),
    );
  }
}
