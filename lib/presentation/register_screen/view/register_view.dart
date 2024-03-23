import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/base_states.dart';
import '../../base/cubit_builder.dart';
import '../../base/cubit_listener.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';
import '../viewmodel/register_viewmodel.dart';
import 'widgets/register_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: ColorManager.transparent,
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
            child: BlocProvider(
              create: (context) => RegisterViewModel()..start(),
              child: BlocConsumer<RegisterViewModel, BaseStates>(
                listener: (context, state) {
                  baseListener(context, state);
                },
                builder: (context, state) {
                  return baseBuilder(
                      context,
                      state,
                      RegisterBody(
                        viewModel: RegisterViewModel.get(context),
                      ));
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
