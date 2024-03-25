import 'package:flutter/material.dart';

import '../../../../domain/models/enums.dart';
import '../../../common/widget/main_button.dart';
import '../../viewmodel/register_viewmodel.dart';

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
