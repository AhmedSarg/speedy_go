import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../domain/models/user_manager.dart';
import '../../../domain/usecase/change_driver_status_usecase.dart';
import '../../base/base_cubit.dart';
import '../../base/base_states.dart';
import '../states/driver_trip_states.dart';
import '../view/pages/accept_ride_page.dart';
import '../view/pages/running_trip.dart';
import '../view/pages/trip_edit_cost.dart';
import '../view/pages/trip_finished_page.dart';
import '../view/pages/waiting_page.dart';
import '../../base/base_cubit.dart';
import '../view/pages/accept_ride_page.dart';
import '../view/pages/run_mode_page.dart';
import '../view/pages/running_trip.dart';
import '../view/pages/trip_edit_cost.dart';
import '../view/pages/trip_finished_page.dart';
import '../view/pages/waiting_page.dart';
import '../view/states/driver_trip_states.dart';

class DriverTripViewModel extends BaseCubit
    implements DriverTripViewModelInput, DriverTripViewModelOutput {
  static DriverTripViewModel get(context) => BlocProvider.of(context);

  final UserManager _userManager;
  final ChangeDriverStatusUseCase _changeDriverStatusUseCase;

  DriverTripViewModel(this._userManager, this._changeDriverStatusUseCase);

  bool _driverStatus = false, _isAccepted = false;

  Stream<LatLng>? _positionStream;

  StreamSubscription<LatLng>? _positionSubscription;

  int _indexPassenger = 0;

  final TextEditingController _costController = TextEditingController();

  int _indexPage = 0;

  Widget? _contentPage;

  updatePage() {
    if (_indexPage == 0) {
      _contentPage = RunMode();
    } else if (_indexPage == 1) {
      _contentPage = WaitingSearchingForPassengers();
    } else if (_indexPage == 2) {
      _contentPage = AcceptRide();
    } else if (_indexPage == 3) {
      _contentPage = EditCost();
    } else if (_indexPage == 4) {
      _contentPage = RunningTrip();
    } else if (_indexPage == 5) {
      _contentPage = TripEnd();
    } else if (_indexPage == 6) {
      emit(RatePassengerState());
    } else {
      _driverStatus = false;
    }
    emit(ChangePageState());
  }

  nextPage() {
    if (_indexPage <= 6) {
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

  toggleChangeStatusDialog() {
    emit(ChangeDriverStatusState());
  }

  reset(){
    _indexPage = 0;
    updatePage();
  }

  Future<void> toggleDriverStatusUi() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    if (!_driverStatus) {
      _getLocationStream();
      _positionSubscription = _positionStream?.listen(null);
    } else {
      toggleDriverStatusRemote();
    }
  }

  Future<void> toggleDriverStatusRemote() async {
    await _changeDriverStatusUseCase(
      ChangeDriverStatusUseCaseInput(
        online: !_driverStatus,
        driverId: _userManager.getCurrentDriver!.uuid,
        coordinatesSubscription: _positionSubscription,
      ),
    ).then(
      (value) {
        value.fold(
          (l) {
            emit(
              ErrorState(
                failure: l,
                displayType: DisplayType.popUpDialog,
              ),
            );
          },
          (r) {
            _driverStatus = !_driverStatus;
            if (!_driverStatus) {
              _positionStream = null;
              _positionSubscription = null;
              _indexPage = 0;
              updatePage();
            }
          },
        );
      },
    );
    emit(DriverStatusChangedState());
  }

  _getLocationStream() {
    emit(CheckPermissionsState());
    _positionStream = Geolocator.getPositionStream().map(
          (gPos) => LatLng(
        gPos.latitude,
        gPos.longitude,
      ),
    );
  }

  updateIndexPassenger(bool isIncrement) {
    _indexPassenger = isIncrement ? _indexPassenger + 1 : _indexPassenger - 1;
    updatePage();
  }

  @override
  void start() {
    updatePage();
  }

  @override
  int get getIndexPassenger {
    _indexPassenger = _indexPassenger <= 0 ? 0 : _indexPassenger;
    return _indexPassenger;
  }

  @override
  bool get getDriverStatus => _driverStatus;

  @override
  bool get getIsAccepted => _isAccepted;

  @override
  TextEditingController get getNewCostController => _costController;

  @override
  int get getIndexPage => _indexPage;

  @override
  Widget? get getPage => _contentPage;

  @override
  set setIsAccepted(bool isAccepted) {
    _isAccepted = isAccepted;
    updatePage();
  }
}

abstract class DriverTripViewModelInput {
  set setIsAccepted(bool isAccepted);
}

abstract class DriverTripViewModelOutput {
  bool get getDriverStatus;

  bool get getIsAccepted;

  int get getIndexPassenger;

  int get getIndexPage;

  TextEditingController get getNewCostController;

  Widget? get getPage;
}
