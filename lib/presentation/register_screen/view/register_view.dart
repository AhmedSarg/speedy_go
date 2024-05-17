import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/resources/routes_manager.dart';

import '../../../app/sl.dart';
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
                create: (context) => RegisterViewModel(sl(), sl())..start(),
                child: BlocConsumer<RegisterViewModel, BaseStates>(
                  listener: (context, state) {
                    RegisterViewModel viewModel =
                        RegisterViewModel.get(context);
                    if (state is RegisterPassengerState) {
                      viewModel.setBoxContent =
                          passengerRegisterWidgets(context, viewModel, formKey);
                    } else if (state is PickFileState) {
                      // showAboutDialog(context: context);
                    } else if (state is RegisterCarState) {
                      viewModel.setBoxContent =
                          carRegisterWidgets(context, viewModel, formKey);
                      viewModel.animateToDriver();
                    } else if (state is RegisterTukTukState) {
                      viewModel.setBoxContent =
                          tukTukRegisterWidgets(context, viewModel, formKey);
                      viewModel.animateToDriver();
                    } else if (state is RegisterBusState) {
                      viewModel.setBoxContent =
                          busRegisterWidgets(context, viewModel, formKey);
                      viewModel.animateToDriver();
                    } else if (state is RegisterImagePickSuccessState) {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          content: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s10),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image.file(state.image),
                          ),
                        ),
                      );
                    } else if (state is RegisterImagePickFailedState) {
                    } else if (state is RegisterTypeSelectionState) {
                      Navigator.pop(context);
                    } else if (state is RegisterVerifyPhoneNumberState) {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Routes.verificationRoute);
                    } else if (state is SuccessState) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.mainLayoutRoute,
                        ModalRoute.withName('/'),
                      );
                    } else if (state is ErrorState) {
                      Navigator.of(context, rootNavigator: true).pop();
                    }
                    baseListener(context, state);
                  },
                  builder: (context, state) {
                    RegisterViewModel viewModel =
                        RegisterViewModel.get(context);
                    if (state is RegisterVehicleSelectionState) {
                      viewModel.setContent =
                          RegisterVehicleSelectionBody(viewModel: viewModel);
                    } else if (state is RegisterPassengerState) {
                      viewModel.setBoxContent =
                          passengerRegisterWidgets(context, viewModel, formKey);
                      viewModel.setContent = RegisterBody(viewModel: viewModel);
                    } else if (state is LoadingState ||
                        state is ErrorState ||
                        state is SuccessState ||
                        state is RegisterTypeSelectionState) {
                    } else {
                      viewModel.setContent = RegisterBody(viewModel: viewModel);
                    }
                    return baseBuilder(context, state, viewModel.getContent);
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
