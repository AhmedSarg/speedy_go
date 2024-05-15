import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../app/sl.dart';
import '../../../../../base/base_states.dart';
import '../../../../../base/cubit_builder.dart';
import '../../../../../base/cubit_listener.dart';
import '../viewmodel/my_buses_viewmodel.dart';
import 'my_buses_body.dart';

class MyBusesScreen extends StatelessWidget {
  const MyBusesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => MyBusesViewModel(sl())..start(),
        child: BlocConsumer<MyBusesViewModel, BaseStates>(
          listener: (context, state) {
            if (state is ErrorState) {
              Navigator.pop(context);
            }
            baseListener(context, state);
          },
          builder: (context, state) {
            return baseBuilder(
              context,
              state,
              MyBusesBody(viewModel: MyBusesViewModel.get(context)),
            );
          },
        ),
      ),
    );
  }
}
