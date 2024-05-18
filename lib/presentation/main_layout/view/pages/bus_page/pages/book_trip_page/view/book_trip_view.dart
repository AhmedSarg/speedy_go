import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';
import 'package:speedy_go/presentation/resources/routes_manager.dart';

import '../../../../../../../../app/sl.dart';
import '../../../../../../../base/base_states.dart';
import '../../../../../../../base/cubit_builder.dart';
import '../../../../../../../base/cubit_listener.dart';
import '../states/book_trip_states.dart';
import '../viewmodel/book_trip_viewmodel.dart';
import 'book_trip_body.dart';

class BookTripScreen extends StatelessWidget {
  const BookTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: BlocProvider(
        create: (_) => BookTripViewModel(sl())..start(),
        child: BlocConsumer<BookTripViewModel, BaseStates>(
          listener: (context, state) {
            if (state is BusDataSuccessState) {
              Navigator.pop(context);
              Navigator.pushNamed(context, Routes.viewBusTripsRoute);
            }
            baseListener(context, state);
          },
          builder: (context, state) {
            return baseBuilder(
              context,
              state,
              BookTripsBody(viewModel: BookTripViewModel.get(context)),
            );
          },
        ),
      ),
    );
  }
}
