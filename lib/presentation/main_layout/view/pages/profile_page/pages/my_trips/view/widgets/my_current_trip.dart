import 'package:flutter/material.dart';


import '../../../../../../../../common/widget/main_trip_item.dart';

class MyCurrentTrip extends StatelessWidget {
  const MyCurrentTrip({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return const MainTripItem();
      },
      itemCount: 3,
    );
  }
}
