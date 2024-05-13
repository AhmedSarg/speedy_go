import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/buses_screen/pages/drawer/view/widgets/drawer_body.dart';
import 'package:speedy_go/presentation/buses_screen/pages/drawer/viewmodel/drawer_viewmodel.dart';
import 'package:speedy_go/presentation/buses_screen/pages/my_buses_screen/view/widgets/my_buses_body.dart';

import '../../../../../app/sl.dart';
import '../../../../base/base_states.dart';
import '../../../../base/cubit_builder.dart';
import '../../../../base/cubit_listener.dart';
import '../../../../login_screen/view/login_view.dart';
import '../states/logoutstates.dart';

class DrawerBuse extends StatelessWidget {
  const DrawerBuse({super.key});

  @override
  Widget build(BuildContext context) {
    return
      BlocProvider(
        create: (context) => DrawerViewModel(sl())..start(),
        child: BlocConsumer<DrawerViewModel, BaseStates>(
          listener: (context, state) {
            if (state is ErrorState) {
              Navigator.pop(context);
            } else if (state is LogoutSuccessState) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
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
