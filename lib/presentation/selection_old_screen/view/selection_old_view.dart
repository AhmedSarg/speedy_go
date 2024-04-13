import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/base/base_states.dart';
import 'package:speedy_go/presentation/base/cubit_listener.dart';
import 'package:speedy_go/presentation/selection_old_screen/viewmodel/selection_old_viewmodel.dart';

import '../../base/cubit_builder.dart';
import '../../resources/values_manager.dart';
import 'widgets/selection_old_body.dart';

class SelectionOldScreen extends StatelessWidget {
  const SelectionOldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: AppSize.infinity,
        height: AppSize.infinity,
        child: BlocProvider(
          create: (context) => SelectionViewModel()..start(),
          child: BlocConsumer<SelectionViewModel, BaseStates>(
            listener: (context, state) {
              baseListener(context, state);
            },
            builder: (context, state) {
              return baseBuilder(context, state,
                  SelectionOldBody(viewModel: SelectionViewModel.get(context)));
            },
          ),
        ),
      ),
    );
  }
}
