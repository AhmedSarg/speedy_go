import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speedy_go/domain/usecase/accept_trip_usecase.dart';
import 'package:speedy_go/domain/usecase/cancel_accept_trip_usecase.dart';

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
  final AcceptTripUseCase _acceptTripUseCase;
  final CancelAcceptTripUseCase _cancelAcceptTripUseCase;

  DriverTripViewModel(
    this._userManager,
    this._changeDriverStatusUseCase,
    this._findTripsUseCase,
    this._acceptTripUseCase,
    this._cancelAcceptTripUseCase,
  );

  bool _driverStatus = false, _isAccepted = false;

  String? _mapStyle;

  Stream<LatLng>? _positionStream;

  StreamSubscription<LatLng>? _positionSubscription;

  LatLng? _userLocation;

  final TextEditingController _costController = TextEditingController();

  int _pageIndex = 0;

  Widget? _contentPage;

  Stream<List<Future<TripPassengerModel>>>? _tripsStream;

  final CarouselController _carouselController = CarouselController();

  List<Future<TripPassengerModel>> _tripsList = [];

  TripPassengerModel? _selectedTrip;

  int _tripIndex = 0;

  updatePage() {
    if (_pageIndex == -2) {
      _contentPage = const EditCost();
    } else if (_pageIndex == -1) {
      _contentPage = const DriverTripLoadingPage();
    } else if (_pageIndex == 0) {
      _contentPage = WaitingSearchingForPassengers();
    } else if (_pageIndex == 1) {
      _contentPage = AcceptRide();
    } else if (_pageIndex == 2) {
      _contentPage = RunningTrip();
    } else if (_pageIndex == 3) {
      _contentPage = TripEnd();
    } else if (_pageIndex == 4) {
      emit(RatePassengerState());
    } else {
      _driverStatus = false;
    }
    emit(ChangePageState());
  }

  nextPage() {
    if (_pageIndex < 5) {
      _pageIndex++;
      updatePage();
    }
  }

  prevPage() {
    if (_pageIndex > 0 && _pageIndex != 2) {
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
    await _findTripsUseCase(FindTripsUseCaseInput(_userLocation!)).then(
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
              (v) async {
                if (v.isNotEmpty) {
                  _selectedTrip = await v[0];
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

  goToEditCost() {
    int tmp = _pageIndex;
    _pageIndex = -2;
    updatePage();
    _pageIndex = tmp;
  }

  handleSelectedTrip(int tripIndex, _) async {
    _tripIndex = tripIndex;
    _selectedTrip = await _tripsList[tripIndex];
    updatePage();
  }

  Future<void> acceptTrip([int? newPrice]) async {
    _isAccepted = true;
    updatePage();
    await _acceptTripUseCase(
      AcceptTripUseCaseInput(
        tripId: _selectedTrip!.id,
        driverId: _userManager.getCurrentDriver!.uuid,
        price: newPrice ?? _selectedTrip!.price,
        location: (await getLocationName(_userLocation!)) ?? "Unknown Location",
        coordinates: _userLocation!,
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
            if (await r) {
              nextPage();
            } else {
              _isAccepted = false;
              updatePage();
            }
          },
        );
      },
    );
  }

  Future<String?> getLocationName(LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
      if (placemarks.isNotEmpty) {
        for (Placemark placemark in placemarks) {
          if (placemark.name != null &&
              placemark.name!.isNotEmpty &&
              !placemark.name!.contains(RegExp(r'[0-9]')) &&
              !placemark.name!.contains('+')) {
            return placemark.name;
          }
        }
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error finding nearest popular place: $e');
      }
      return null;
    }
  }

  Future<void> cancelAcceptTrip() async {
    _isAccepted = false;
    updatePage();
    await _cancelAcceptTripUseCase(
      CancelAcceptTripUseCaseInput(
        tripId: _selectedTrip!.id,
        driverId: _userManager.getCurrentDriver!.uuid,
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
          (r) {},
        );
      },
    );
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
  int get getTripPrice => _selectedTrip!.price;

  @override
  int get getPageIndex => _pageIndex;

  @override
  Widget? get getPage => _contentPage;

  @override
  String get getMapStyle => _mapStyle!;

  @override
  LatLng get getUserLocation => _userLocation!;

  @override
  Stream<List<Future<TripPassengerModel>>> get getTripsStream => _tripsStream!;

  @override
  CarouselController get getCarouselController => _carouselController;

  @override
  int get getTripIndex => _tripIndex;

  @override
  List<Future<TripPassengerModel>> get getTripsList => _tripsList;

  @override
  TripPassengerModel get getSelectedTrip => _selectedTrip!;

  @override
  set setTripsList(List<Future<TripPassengerModel>> trips) {
    _tripsList = trips;
  }

  @override
  set setTripPrice(int newPrice) {}
}

abstract class DriverTripViewModelInput {
  set setTripsList(List<Future<TripPassengerModel>> trips);

  set setTripPrice(int newPrice);
}

abstract class DriverTripViewModelOutput {
  bool get getDriverStatus;

  bool get getIsAccepted;

  int get getPageIndex;

  TextEditingController get getNewCostController;

  int get getTripPrice;

  Widget? get getPage;

  String get getMapStyle;

  LatLng get getUserLocation;

  Stream<List<Future<TripPassengerModel>>> get getTripsStream;

  CarouselController get getCarouselController;

  int get getTripIndex;

  List<Future<TripPassengerModel>> get getTripsList;

  TripPassengerModel get getSelectedTrip;
}
