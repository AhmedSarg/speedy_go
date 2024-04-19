import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/base/base_cubit.dart';

import '../view/states/driver_trip_states.dart';

class DriverTripViewModel extends BaseCubit
    implements DriverTripViewModelInput, DriverTripViewModelOutput {
  bool _mode = false, _showContainer = false, _isAccepted = false;
  int _indexPassenger = 0;
  late final TextEditingController _costController =  TextEditingController();

  static DriverTripViewModel get(context) => BlocProvider.of(context);

  @override
  void start() {

  }

  @override
  bool get getMode => _mode;

  toggleMode() {
    _mode = !_mode;
    if (_mode) _showContainer = false;
    emit(ChangeModeState());
  }

  @override
  bool get getShowContainer => _showContainer;

  toggleShowContainer() {
    _showContainer = !_showContainer;
    emit(ChangeShowContainerState());
  }

  updateIndexPassenger(bool isIncrement) {
    //get next or previous id
    _indexPassenger = isIncrement ? _indexPassenger + 1 : _indexPassenger - 1;
    emit(UpdateIndexPassengerState());
  }

  @override
  int get getIndexPassenger {
    _indexPassenger = _indexPassenger <= 0 ? 0 : _indexPassenger;
    return _indexPassenger;
  }

  @override
  bool get getIsAccepted => _isAccepted;

  @override
  void setIsAccepted(bool isAccepted) {
    _isAccepted = isAccepted;
    emit(AcceptedState());
  }

  @override
  TextEditingController get getNewCostController => _costController;

}

abstract class DriverTripViewModelInput {
  void setIsAccepted(bool isAccepted);
}

abstract class DriverTripViewModelOutput {
  bool get getMode;
  bool get getIsAccepted;
  bool get getShowContainer;
  int get getIndexPassenger;
  TextEditingController get getNewCostController;
}
