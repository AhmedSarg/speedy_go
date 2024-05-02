import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../domain/models/domain.dart';
import '../../../domain/models/user_manager.dart';
import '../../../domain/usecase/change_driver_status_usecase.dart';
import '../../../domain/usecase/find_trips_usecase.dart';
import '../../base/base_cubit.dart';
import '../../base/base_states.dart';
import '../states/driver_trip_states.dart';
import '../view/pages/accept_ride_page.dart';
import '../view/pages/loading_page.dart';
import '../view/pages/running_trip.dart';
import '../view/pages/trip_edit_cost.dart';
import '../view/pages/trip_finished_page.dart';
import '../view/pages/waiting_page.dart';

class DriverTripViewModel extends BaseCubit
    implements DriverTripViewModelInput, DriverTripViewModelOutput {
  static DriverTripViewModel get(context) => BlocProvider.of(context);

  final UserManager _userManager;
  final ChangeDriverStatusUseCase _changeDriverStatusUseCase;
  final FindTripsUseCase _findTripsUseCase;

  DriverTripViewModel(this._userManager, this._changeDriverStatusUseCase,
      this._findTripsUseCase);

  bool _driverStatus = false, _isAccepted = false;

  String? _mapStyle;

  Stream<LatLng>? _positionStream;

  StreamSubscription<LatLng>? _positionSubscription;

  LatLng? _userLocation;

  final TextEditingController _costController = TextEditingController();

  int _pageIndex = 0;

  Widget? _contentPage;

  Stream<List<TripPassengerModel>>? _tripsStream;

  final CarouselController _carouselController = CarouselController();

  List<TripPassengerModel> _tripsList = [];

  int _tripIndex = 0;

  updatePage() {
    if (_pageIndex == -1) {
      _contentPage = const DriverTripLoadingPage();
    } else if (_pageIndex == 0) {
      _contentPage = WaitingSearchingForPassengers();
    } else if (_pageIndex == 1) {
      _contentPage = AcceptRide();
    } else if (_pageIndex == 2) {
      _contentPage = EditCost();
    } else if (_pageIndex == 3) {
      _contentPage = RunningTrip();
    } else if (_pageIndex == 4) {
      _contentPage = TripEnd();
    } else if (_pageIndex == 5) {
      emit(RatePassengerState());
    } else {
      _driverStatus = false;
    }
    emit(ChangePageState());
  }

  nextPage() {
    if (_pageIndex < 6) {
      _pageIndex++;
      updatePage();
    }
  }

  prevPage() {
    if (_pageIndex > 0) {
      _pageIndex--;
      updatePage();
    }
  }

  reset() {
    _pageIndex = 0;
    updatePage();
  }

  _loadContent() {
    int lastIndex = _pageIndex;
    _pageIndex = -1;
    updatePage();
    _pageIndex = lastIndex;
  }

  toggleChangeStatusDialog() {
    emit(ChangeDriverStatusState());
  }

  Future<void> toggleDriverStatusUi() async {
    if (!_driverStatus) {
      _getLocationStream();
      _positionSubscription = _positionStream?.listen(null);
    } else {
      toggleDriverStatusRemote();
    }
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

  Future<void> toggleDriverStatusRemote() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
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
          (r) async {
            _driverStatus = !_driverStatus;
            if (!_driverStatus) {
              _positionStream = null;
              _positionSubscription = null;
              reset();
            } else {
              await _fetchMapStyle();
              await _fetchUserLocation();
              await _findTrips();
            }
            emit(DriverStatusChangedState());
          },
        );
      },
    );
  }

  Future<void> _fetchMapStyle() async {
    _mapStyle ??= await rootBundle.loadString('assets/maps/dark_map.json');
  }

  Future<void> _fetchUserLocation() async {
    if (_userLocation == null) {
      Position position = await Geolocator.getCurrentPosition();
      _userLocation = LatLng(position.latitude, position.longitude);
    }
  }

  Future<void> _findTrips() async {
    await _findTripsUseCase(null).then(
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
            _tripsStream = r;
            late StreamSubscription sub;
            sub = _tripsStream!.listen(
              (v) {
                if (v.isNotEmpty) {
                  nextPage();
                  sub.cancel();
                }
              },
            );
          },
        );
      },
    );
  }

  nextTrip() {
    _carouselController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  prevTrip() {
    _carouselController.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  handleSelectedTrip(int tripIndex, _) {
    _tripIndex = tripIndex;
    updatePage();
  }

  @override
  void start() {
    updatePage();
  }

  @override
  bool get getDriverStatus => _driverStatus;

  @override
  bool get getIsAccepted => _isAccepted;

  @override
  TextEditingController get getNewCostController => _costController;

  @override
  int get getPageIndex => _pageIndex;

  @override
  Widget? get getPage => _contentPage;

  @override
  String get getMapStyle => _mapStyle!;

  @override
  LatLng get getUserLocation => _userLocation!;

  @override
  Stream<List<TripPassengerModel>> get getTripsStream => _tripsStream!;

  @override
  CarouselController get getCarouselController => _carouselController;

  @override
  int get getTripIndex => _tripIndex;

  @override
  List<TripPassengerModel> get getTripsList => _tripsList;

  @override
  set setIsAccepted(bool isAccepted) {
    _isAccepted = isAccepted;
    updatePage();
  }

  @override
  set setTripsList(List<TripPassengerModel> trips) {
    _tripsList = trips;
  }
}

abstract class DriverTripViewModelInput {
  set setIsAccepted(bool isAccepted);

  set setTripsList(List<TripPassengerModel> trips);
}

abstract class DriverTripViewModelOutput {
  bool get getDriverStatus;

  bool get getIsAccepted;

  int get getPageIndex;

  TextEditingController get getNewCostController;

  Widget? get getPage;

  String get getMapStyle;

  LatLng get getUserLocation;

  Stream<List<TripPassengerModel>> get getTripsStream;

  CarouselController get getCarouselController;

  int get getTripIndex;

  List<TripPassengerModel> get getTripsList;
}
