import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/buses_screen/pages/add_trip_screen/view/widgets/add_trip_body.dart';
import 'package:speedy_go/presentation/buses_screen/pages/add_trip_screen/viewmodel/add_trip_viewmodel.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';

import '../../../../base/base_states.dart';
import '../../../../base/cubit_builder.dart';
import '../../../../base/cubit_listener.dart';
import '../../../../login_screen/viewmodel/login_viewmodel.dart';

class AddTripScreen extends StatelessWidget {
  const AddTripScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: BlocProvider(
        create: (_) => AddTripViewModel()..start(),
        child: BlocConsumer<AddTripViewModel, BaseStates>(
          listener: (context, state) {
            baseListener(context, state);
          },
          builder: (context, state) {
            return baseBuilder(
              context,
              state,
              AddTripBody(viewModel: AddTripViewModel()),

            );
          },
        ),
      ),
    );
  }
}
