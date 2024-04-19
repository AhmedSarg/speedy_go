import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/profile_page/pages/support/view/widgets/support_screen_body.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/profile_page/pages/support/viewmodel/support_viewmodel.dart';

import '../../../../../../../base/base_states.dart';
import '../../../../../../../base/cubit_builder.dart';
import '../../../../../../../base/cubit_listener.dart';
import '../../../../../../../resources/color_manager.dart';


class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: BlocProvider(
        create: (_) => SupportViewModel()..start(),
        child: BlocConsumer<SupportViewModel, BaseStates>(
          listener: (context, state) {
            baseListener(context, state);
          },
          builder: (context, state) {
            return baseBuilder(
              context,
              state,
              SupportBodyScreen(viewModel: SupportViewModel.get(context)),
            );
          },
        ),
      ),
    );


  }
}
