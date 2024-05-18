import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../app/sl.dart';
import '../viewmodel/my_trips_viewmodel.dart';
import 'my_trips_body.dart';

class MyTripsScreen extends StatelessWidget {
  const MyTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => MyTripsViewModel(sl(), sl())..start(),
        child: const MyTripsBody(),
      ),
    );
  }
}
