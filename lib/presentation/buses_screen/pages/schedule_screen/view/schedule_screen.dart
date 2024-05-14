import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/buses_screen/pages/my_buses_screen/view/widgets/my_buses_body.dart';
import 'package:speedy_go/presentation/buses_screen/pages/schedule_screen/view/widgets/sehedule_body.dart';

import '../../../../../app/sl.dart';
import '../../../../base/base_states.dart';
import '../../../../base/cubit_builder.dart';
import '../../../../base/cubit_listener.dart';
import '../viewmodel/schedule_viewmodel.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ScheduleViewModel(sl())..start(),
        child: BlocConsumer<ScheduleViewModel, BaseStates>(
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
              SehedualBodyScreen(viewModel: ScheduleViewModel.get(context)),
            );
          },
        ),
      ),
    );
  }
}
