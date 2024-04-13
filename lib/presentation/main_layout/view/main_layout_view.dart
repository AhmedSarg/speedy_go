import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/base_states.dart';
import '../../base/cubit_builder.dart';
import '../../base/cubit_listener.dart';
import '../viewmodel/main_viewmodel.dart';
import 'main_layout_body.dart';

class MainLayoutScreen extends StatelessWidget {
  const MainLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => MainViewModel()..start(),
        child: BlocConsumer<MainViewModel, BaseStates>(
          listener: (context, state) {
            baseListener(context, state);
          },
          builder: (context, state) {
            return baseBuilder(
              context,
              state,
              MainLayoutBody(viewModel: MainViewModel.get(context)),
            );
          },
        ),
      ),
    );
  }
}
