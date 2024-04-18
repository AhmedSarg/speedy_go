import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../base/base_states.dart';
import '../../../../../../../base/cubit_builder.dart';
import '../../../../../../../base/cubit_listener.dart';
import '../../../../../../../resources/color_manager.dart';
import '../viewmodel/edit_profile_viewmodel.dart';
import 'widgets/edit_profile_body.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: BlocProvider(
        create: (_) => EditProfileViewModel()..start(),
        child: BlocConsumer<EditProfileViewModel, BaseStates>(
          listener: (context, state) {
            baseListener(context, state);
          },
          builder: (context, state) {
            return baseBuilder(
              context,
              state,
              EditProfileBody(viewModel: EditProfileViewModel.get(context)),
            );
          },
        ),
      ),
    );


  }
}
