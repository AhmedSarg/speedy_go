import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/base/cubit_builder.dart';
import 'package:speedy_go/presentation/base/cubit_listener.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/bus_page/pages/bus_trips_page/view/bus_trips_body.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/bus_page/pages/bus_trips_page/viewmodel/bus_trips_viewmodel.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

import '../../../../../../../base/base_states.dart';

class BusTripsPage extends StatelessWidget {
  const BusTripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: AppSize.infinity,
        height: AppSize.infinity,
        child: BlocProvider(
          create: (context) => BusTripsViewModel()..start(),
          child: BlocConsumer<BusTripsViewModel, BaseStates>(
            listener: (context, state) {
              baseListener(context, state);
            },
            builder: (context, state) {
              return baseBuilder(context, state, BusTripsBody());
            },
          )
        ),
      ),
    );
  }
}
