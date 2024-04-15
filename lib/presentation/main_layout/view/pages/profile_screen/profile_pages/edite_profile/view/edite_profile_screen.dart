import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/profile_screen/profile_pages/edite_profile/view/widgets/edite_profile_body.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/profile_screen/view/widgets/google_map.dart';

import '../../../../../../../base/base_states.dart';
import '../../../../../../../base/cubit_builder.dart';
import '../../../../../../../base/cubit_listener.dart';
import '../../../../../../../common/widget/main_text_field.dart';
import '../../../../../../../resources/color_manager.dart';
import '../../../../../../../resources/values_manager.dart';
import '../viewmodel/edite_profile_viwemmodel.dart';

class ProfileEditeScreen extends StatelessWidget {
  const ProfileEditeScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: BlocProvider(
        create: (_) => EditeProileViewModel()..start(),
        child: BlocConsumer<EditeProileViewModel, BaseStates>(
          listener: (context, state) {
            baseListener(context, state);
          },
          builder: (context, state) {
            return baseBuilder(
              context,
              state,
              EditeProfileBody(viewModel: EditeProileViewModel.get(context)),
            );
          },
        ),
      ),
    );


  }
}
