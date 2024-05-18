import 'package:flutter/material.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/profile_page/pages/my_trips/view/widgets/history_trip_item.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/profile_page/pages/my_trips/viewmodel/my_trips_viewmodel.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

class CurrentTrips extends StatelessWidget {
  const CurrentTrips({super.key});

  static late MyTripsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = MyTripsViewModel.get(context);
    return ListView.builder(
      padding: EdgeInsets.all(AppPadding.p20),
      itemBuilder: (context, index) {
        return HistoryTripItem(tripModel: viewModel.getCurrentTrips[index]);
      },
      itemCount: viewModel.getCurrentTrips.length,
    );
  }
}
