import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../app/sl.dart';
import '../../../../../base/base_states.dart';
import '../../../../../base/cubit_builder.dart';
import '../../../../../base/cubit_listener.dart';
import '../../../../../resources/color_manager.dart';
import '../../../../../resources/values_manager.dart';
import '../states/add_bus_states.dart';
import '../viewmodel/add_bus_viewmodel.dart';
import 'add_bus_body.dart';

class AddBusScreen extends StatelessWidget {
  const AddBusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: BlocProvider(
        create: (context) => AddBusViewModel(sl())..start(),
        child: BlocConsumer<AddBusViewModel, BaseStates>(
          listener: (context, state) {
            if (state is SuccessState) {
              AddBusViewModel.get(context).clear();
              Navigator.pop(context);
            } else if (state is AddBusImagePickedSuccessfully) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  content: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s10),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.file(state.image),
                  ),
                ),
              );
            }
            baseListener(context, state);
          },
          builder: (context, state) {
            return baseBuilder(context, state, AddBusBody());
          },
        ),
      ),
    );
  }
}
