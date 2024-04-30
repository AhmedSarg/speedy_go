
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/base_cubit.dart';

class BusesViewModel extends BaseCubit
    implements PassengerTripViewModelInput, PassengerTripViewModelOutput {
  static BusesViewModel get(context) => BlocProvider.of(context);

  @override
  void start() {
    // TODO: implement start
  }

}


abstract class PassengerTripViewModelInput {
}


abstract class PassengerTripViewModelOutput {
}
