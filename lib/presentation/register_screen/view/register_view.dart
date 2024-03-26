import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/base_states.dart';
import '../../base/cubit_builder.dart';
import '../../base/cubit_listener.dart';
import '../../resources/assets_manager.dart';
import '../../resources/values_manager.dart';
import '../viewmodel/register_viewmodel.dart';
import 'states/register_states.dart';
import 'widgets/register_body.dart';
import 'widgets/register_boxes.dart';
import 'widgets/register_vehicle_selection_body.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
            height: AppSize.infinity,
            width: AppSize.infinity,
            child: Image.asset(
              ImageAssets.loginBackgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          Form(
            key: formKey,
            child: SizedBox(
              width: AppSize.infinity,
              height: AppSize.infinity,
              child: BlocProvider(
                create: (context) => RegisterViewModel()..start(),
                child: BlocConsumer<RegisterViewModel, BaseStates>(
                  listener: (context, state) {
                    RegisterViewModel viewModel = RegisterViewModel.get(context);
                    if (state is RegisterPassengerState) {
                      viewModel.setBoxContent =
                          passengerRegisterWidgets(context, viewModel, formKey);
                    } else if (state is RegisterCarState) {
                      viewModel.setBoxContent = carRegisterWidgets(context, viewModel, formKey);
                      viewModel.animateToDriver();
                    } else if (state is RegisterTukTukState) {
                      viewModel.setBoxContent = tuktukRegisterWidgets(context, viewModel, formKey);
                      viewModel.animateToDriver();
                    } else if (state is RegisterBusState) {
                      viewModel.setBoxContent = busRegisterWidgets(context, viewModel, formKey);
                      viewModel.animateToDriver();
                    }
                    baseListener(context, state);
                  },
                  builder: (context, state) {
                    Widget content;
                    RegisterViewModel viewModel = RegisterViewModel.get(context);
                    if (state is RegisterVehicleSelectionState) {
                      content = RegisterVehicleSelectionBody(viewModel: viewModel);
                    } else if (state is RegisterPassengerState) {
                      viewModel.setBoxContent =
                          passengerRegisterWidgets(context, viewModel, formKey);
                      content = RegisterBody(viewModel: viewModel);
                    } else {
                      content = RegisterBody(viewModel: viewModel);
                    }
                    return baseBuilder(context, state, content);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
