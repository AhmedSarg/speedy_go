import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../app/sl.dart';
import '../../../../../base/base_states.dart';
import '../../../../../base/cubit_builder.dart';
import '../../../../../base/cubit_listener.dart';
import '../states/logout_states.dart';
import '../viewmodel/drawer_viewmodel.dart';
import 'drawer_body.dart';

class BusesScreenDrawer extends StatelessWidget {
  const BusesScreenDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DrawerViewModel(sl())..start(),
      child: BlocConsumer<DrawerViewModel, BaseStates>(
        listener: (context, state) {
          if (state is ErrorState) {
            Navigator.pop(context);
          } else if (state is LogoutSuccessState) {
            Scaffold.of(context).closeDrawer();
          }
          baseListener(context, state);
        },
        builder: (context, state) {
          return baseBuilder(
            context,
            state,
            DrawerBody(viewModel: DrawerViewModel.get(context)),
          );
        },
      ),
    );
  }
}
