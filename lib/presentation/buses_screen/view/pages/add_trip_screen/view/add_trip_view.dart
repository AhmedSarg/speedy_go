import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../app/sl.dart';
import '../../../../../base/base_states.dart';
import '../../../../../base/cubit_builder.dart';
import '../../../../../base/cubit_listener.dart';
import '../../../../../resources/color_manager.dart';
import '../viewmodel/add_trip_viewmodel.dart';
import 'add_trip_body.dart';

class AddBusTripScreen extends StatelessWidget {
  const AddBusTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: BlocProvider(
        create: (context) => AddTripViewModel(sl())..start(),
        child: BlocConsumer<AddTripViewModel, BaseStates>(
          listener: (context, state) {
            if (state is SuccessState) {
              Navigator.pop(context);
            } else if (state is ErrorState) {
              Navigator.pop(context);
            }
            baseListener(context, state);
          },
          builder: (context, state) {
            return baseBuilder(
              context,
              state,
              AddTripBody(viewModel: AddTripViewModel.get(context)),
            );
          },
        ),
      ),
    );
  }
}
