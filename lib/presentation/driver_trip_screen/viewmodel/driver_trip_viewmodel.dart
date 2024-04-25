import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/base/base_cubit.dart';
import 'package:speedy_go/presentation/driver_trip_screen/view/pages/accept_ride_page.dart';
import 'package:speedy_go/presentation/driver_trip_screen/view/pages/running_trip.dart';
import 'package:speedy_go/presentation/driver_trip_screen/view/pages/trip_edit_cost.dart';
import 'package:speedy_go/presentation/driver_trip_screen/view/pages/trip_finished_page.dart';
import 'package:speedy_go/presentation/driver_trip_screen/view/pages/waiting_page.dart';

import '../view/states/driver_trip_states.dart';

class DriverTripViewModel extends BaseCubit
    implements DriverTripViewModelInput, DriverTripViewModelOutput {
  bool _mode = false, _showContainer = false, _isAccepted = false;
  int _indexPassenger = 0;
  late final TextEditingController _costController = TextEditingController();

  int _indexPage = 0;
  Widget? _contentPage;

  static DriverTripViewModel get(context) => BlocProvider.of(context);

  @override
  void start() {
    updatePage();
  }

  updatePage() {
    if (_indexPage == 0) {
      _contentPage = WaitingSearchingForPassengers();
      // emit(WaitingSearchingForPassengersState());
    } else if (_indexPage == 1) {
      _contentPage = AcceptRide();
      // emit(AcceptRideState());
    } else if (_indexPage == 2) {
      _contentPage = EditCost();
      // emit(EditCostState());
    } else if (_indexPage == 3) {
      _contentPage = RunningTrip();
      // emit(RunningTripState());
    } else if (_indexPage == 4) {
      _contentPage = TripEnd();
      // emit(EndTripState());
    } else if (_indexPage == 5) {
      emit(RatePassengerState());
    } else {
      //error
    }
    emit(ChangePageState());
  }

  nextPage() {
    if (_indexPage < 6) {
      _indexPage++;
      updatePage();
    }
  }

  prevPage() {
    if (_indexPage > 0) {
      _indexPage--;
      updatePage();
    }
  }

  toggleMode() {
    _mode = !_mode;
    if (_mode) _showContainer = false;
    emit(ChangeModeState());
  }

  toggleShowContainer() {
    _showContainer = !_showContainer;
    updatePage();
  }

  updateIndexPassenger(bool isIncrement) {
    //get next or previous id
    _indexPassenger = isIncrement ? _indexPassenger + 1 : _indexPassenger - 1;
    updatePage();
  }

  @override
  set setIsAccepted(bool isAccepted) {
    _isAccepted = isAccepted;
    updatePage();
  }

  @override
  int get getIndexPassenger {
    _indexPassenger = _indexPassenger <= 0 ? 0 : _indexPassenger;
    return _indexPassenger;
  }

  @override
  bool get getMode => _mode;

  @override
  bool get getShowContainer => _showContainer;

  @override
  bool get getIsAccepted => _isAccepted;

  @override
  TextEditingController get getNewCostController => _costController;

  @override
  int get getIndexPage => _indexPage;

  @override
  Widget? get getPage => _contentPage;
}

abstract class DriverTripViewModelInput {
  set setIsAccepted(bool isAccepted);
}

abstract class DriverTripViewModelOutput {
  bool get getMode;
  bool get getIsAccepted;
  bool get getShowContainer;
  int get getIndexPassenger;
  int get getIndexPage;
  TextEditingController get getNewCostController;
  Widget? get getPage;
}
