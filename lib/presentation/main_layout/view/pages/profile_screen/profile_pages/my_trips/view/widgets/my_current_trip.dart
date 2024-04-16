import 'package:flutter/material.dart';


import 'Current_trip_item.dart';

class MyCurrentTrip extends StatelessWidget {
  const MyCurrentTrip({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return const CurrentTripItem();
      },
      itemCount: 3,
    );
  }
}
