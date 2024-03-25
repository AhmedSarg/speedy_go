import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/base_states.dart';
import '../../base/cubit_builder.dart';
import '../../base/cubit_listener.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';
import '../viewmodel/register_viewmodel.dart';
import 'states/register_states.dart';
import 'widgets/register_body.dart';
import 'widgets/register_boxes.dart';
import 'widgets/register_vehicle_selection_body.dart';

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
                  RegisterViewModel viewModel = RegisterViewModel.get(context);
                  if (state is RegisterPassengerState) {
                    viewModel.setBoxContent = passengerRegisterWidgets();
                    viewModel.setBoxHeight = AppSize.s600;
                  }
                  else if (state is RegisterCarState) {
                    viewModel.setBoxContent = carRegisterWidgets();
                  }
                  else if (state is RegisterTukTukState) {
                    viewModel.setBoxContent = tuktukRegisterWidgets();
                  }
                  else if (state is RegisterBusState) {
                    viewModel.setBoxContent = busRegisterWidgets();
                  }
                    baseListener(context, state);
                },
                builder: (context, state) {
                  Widget content;
                  RegisterViewModel viewModel = RegisterViewModel.get(context);
                  if (state is RegisterVehicleSelectionState) {
                    content = RegisterVehicleSelectionBody(viewModel: viewModel);
                  }
                  else if (state is RegisterPassengerState) {
                    viewModel.setBoxContent = passengerRegisterWidgets();
                    viewModel.setBoxHeight = AppSize.s600;
                    content = RegisterBody(
                      viewModel: viewModel,
                    );
                  }
                  else {
                    content = RegisterBody(
                      viewModel: viewModel,
                    );
                  }
                  return baseBuilder(context, state, content);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
