import 'package:flutter/material.dart';

import '../../../../../../../../common/widget/main_trip_item.dart';
import '../../viewmodel/my_trips_viewmodel.dart';

class PastTrips extends StatelessWidget {
  const PastTrips({super.key});

  static late MyTripsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = MyTripsViewModel.get(context);
    return ListView.builder(
      itemBuilder: (context, index) {
        return MainTripItem(tripModel: viewModel.getPastTrips[index]);
      },
      itemCount: viewModel.getPastTrips.length,
    );
  }
}
