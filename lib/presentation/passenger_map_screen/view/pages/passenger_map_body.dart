import 'package:flutter/material.dart';
import 'package:speedy_go/domain/models/enums.dart';

import '../../viewmodel/passenger_map_viewmodel.dart';
import 'passenger_map_location.dart';

class PassengerMapBody extends StatelessWidget {
  const PassengerMapBody({super.key});

  static late PassengerMapViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = PassengerMapViewModel.get(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            viewModel.goToMap(LocationMapType.pickup);
          },
          child: const Text('From'),
        ),
        ElevatedButton(
          onPressed: () {
            viewModel.goToMap(LocationMapType.destination);
          },
          child: const Text('To'),
        ),
      ],
    );
  }
}
