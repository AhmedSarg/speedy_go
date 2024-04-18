import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:speedy_go/presentation/main_layout/view/pages/bus_page/view/widgets/book_trip_body.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/bus_page/viewmodel/book_trip_viewmodel.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';

import '../../../../../base/base_states.dart';
import '../../../../../base/cubit_builder.dart';
import '../../../../../base/cubit_listener.dart';


class BookTripScreen extends StatelessWidget {
  const BookTripScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: BlocProvider(
        create: (_) => BookTripViewModel()..start(),
        child: BlocConsumer<BookTripViewModel, BaseStates>(
          listener: (context, state) {
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
