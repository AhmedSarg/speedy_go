import 'package:flutter/material.dart';
import 'package:speedy_go/presentation/passenger_trip_screen/viewmodel/passenger_trip_viewmodel.dart';

class TripLocation extends StatelessWidget {
  const TripLocation({super.key});

  static late PassengerTripViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = PassengerTripViewModel.get(context);
    return GestureDetector(
      onTap: () {
        viewModel.nextPage();
      },
      child: Container(
        color: Colors.red,
        width: 100,
        height: 100,
      ),
    );
  }
}
