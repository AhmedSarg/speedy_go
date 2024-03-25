import 'package:flutter/material.dart';
import 'package:speedy_go/domain/models/enums.dart';
import 'package:speedy_go/presentation/common/widget/main_button.dart';
import 'package:speedy_go/presentation/register_screen/viewmodel/register_viewmodel.dart';

class RegisterVehicleSelectionBody extends StatelessWidget {
  const RegisterVehicleSelectionBody({
    super.key,
    required this.viewModel,
  });

  final RegisterViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AppButton(
          text: 'Car',
          onPressed: () {
            viewModel.setRegisterBoxType = RegisterType.car;
          },
        ),
        AppButton(
          text: 'Tuk Tuk',
          onPressed: () {
            viewModel.setRegisterBoxType = RegisterType.tuktuk;
          },
        ),
        AppButton(
          text: 'Bus',
          onPressed: () {
            viewModel.setRegisterBoxType = RegisterType.bus;
          },
        ),
      ],
    );
  }
}
