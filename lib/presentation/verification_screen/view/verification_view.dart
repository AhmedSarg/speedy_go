import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/sl.dart';
import '../../base/base_states.dart';
import '../../base/cubit_builder.dart';
import '../../base/cubit_listener.dart';
import '../../resources/assets_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';
import '../viewmodel/verification_viewmodel.dart';
import 'widgets/verification_body.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
            height: AppSize.infinity,
            width: AppSize.infinity,
            child: Image.asset(
              ImageAssets.loginBackgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          BlocProvider(
            create: (context) => VerificationViewModel(sl(), sl())..start(),
            child: BlocConsumer<VerificationViewModel, BaseStates>(
              listener: (context, state) {
                if (state is ErrorState) {
                  Navigator.pop(context);
                } else if (state is SuccessState) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.mainLayoutRoute,
                    ModalRoute.withName('/'),
                  );
                }
                baseListener(context, state);
              },
              builder: (context, state) {
                return baseBuilder(
                  context,
                  state,
                  VerificationBody(
                    viewModel: VerificationViewModel.get(context),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
