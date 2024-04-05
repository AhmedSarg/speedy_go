import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/sl.dart';
import '../../base/base_states.dart';
import '../../base/cubit_builder.dart';
import '../../base/cubit_listener.dart';
import '../../resources/routes_manager.dart';
import '../viewmodel/login_viewmodel.dart';
import 'widgets/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginViewModel(sl())..start(),
        child: BlocConsumer<LoginViewModel, BaseStates>(
          listener: (context, state) {
            if (state is SuccessState) {
              // Navigator.pushNamedAndRemoveUntil(
              //   context,
              //   Routes.mainLayoutRoute,
              //   ModalRoute.withName('/'),
              // );
            } else if (state is ErrorState) {
              Navigator.pop(context);
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
