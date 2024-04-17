import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/base/base_cubit.dart';

class DriverTripViewModel extends BaseCubit
    implements DriverTripViewModelInput, DriverTripViewModelOutput {
  static DriverTripViewModel get(context) => BlocProvider.of(context);

  @override
  void start() {}
}

abstract class DriverTripViewModelInput {}

abstract class DriverTripViewModelOutput {}
