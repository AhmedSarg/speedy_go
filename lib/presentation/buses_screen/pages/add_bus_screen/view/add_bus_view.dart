import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/base/cubit_builder.dart';
import 'package:speedy_go/presentation/base/cubit_listener.dart';
import 'package:speedy_go/presentation/buses_screen/pages/add_bus_screen/view/add_bus_body.dart';
import 'package:speedy_go/presentation/buses_screen/pages/add_bus_screen/viewmodel/add_bus_viewmodel.dart';
import 'package:speedy_go/presentation/buses_screen/view/widgets/drawer_widget.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';

import '../../../../../app/sl.dart';
import '../../../../base/base_states.dart';
import '../../../../resources/values_manager.dart';
import '../states/add_bus_states.dart';

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
              Navigator.pop(context);
            }
            else if (state is AddBusImagePickedSuccessfully) {
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
      drawer: const BusesDrawer(),
    );
  }
}
