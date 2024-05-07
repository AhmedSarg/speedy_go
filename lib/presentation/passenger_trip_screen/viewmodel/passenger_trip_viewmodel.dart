import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../domain/models/domain.dart';
import '../../../../../../domain/models/enums.dart';
import '../../../domain/models/user_manager.dart';
import '../../../domain/usecase/accept_driver_usecase.dart';
import '../../../domain/usecase/calculate_two_points_usecase.dart';
import '../../../domain/usecase/cancel_trip_usecase.dart';
import '../../../domain/usecase/end_trip_usecase.dart';
import '../../../domain/usecase/find_drivers_usecase.dart';
import '../../base/base_cubit.dart';
import '../../base/base_states.dart';
import '../../common/data_intent/data_intent.dart';
import '../../common/widget/app_lifecycle_observer.dart';
import '../states/trip_states.dart';
import '../view/pages/trip_confirm.dart';
import '../view/pages/trip_details.dart';
import '../view/pages/trip_driver.dart';
import '../view/pages/trip_loading.dart';
import '../view/pages/trip_price.dart';
import '../view/pages/trip_vehicle.dart';

class PassengerTripViewModel extends BaseCubit
    implements PassengerTripViewModelInput, PassengerTripViewModelOutput {
  static PassengerTripViewModel get(context) => BlocProvider.of(context);

  final UserManager _userManager;
  final FindDriversUseCase _findDriversUseCase;
  final CalculateTwoPointsUseCase _calculateTwoPointsUseCase;
  final CancelTripUseCase _cancelTripUseCase;
  final AcceptDriverUseCase _acceptDriversUseCase;

  PassengerTripViewModel(
    this._userManager,
    this._findDriversUseCase,
    this._calculateTwoPointsUseCase,
    this._cancelTripUseCase,
    this._acceptDriversUseCase,
  );

  final AppLifecycleObserver _appLifecycleObserver = AppLifecycleObserver();

  int _pageIndex = 0;

  Widget? _pageContent;

  TripType? _tripType;

  String? _mapStyle;

  bool _canPop = true;
  String? _tripId;
  late LatLng _pickupLocation;
  late LatLng _destinationLocation;
  int? _tripExpectedTime;
  int? _tripDistance;
  TripDriverModel? _selectedDriver;
  final List<String> _driversIds = [];

  final TextEditingController _priceController = TextEditingController();

  int? _price;
  int? _recommendedPrice;

  Stream<List<Future<TripDriverModel>>>? _driversStream;

  @override
  void start() {
    _fetchMapStyle();
    _appLifecycleObserver.initialize(() {
      if (_tripId != null) {
        prevPage();
      }
    });
    _pickupLocation = DataIntent.popPickupLocation();
    _destinationLocation = DataIntent.popDestinationLocation();
    _setPageContent();
  }

  @override
  Widget? get getPage => _pageContent;

  @override
  int get getPageIndex => _pageIndex;

  @override
  TripType? get getTripType => _tripType;

  @override
  TripDriverModel get getSelectedDriver =>
      _selectedDriver ?? TripDriverModel.fake();

  @override
  List<String> get getDriversIds => _driversIds;

  @override
  Stream<List<Future<TripDriverModel>>> get getDrivers => _driversStream!;

  @override
  bool get getCanPop => _canPop;

  @override
  TextEditingController get getPriceController => _priceController;

  @override
  int get getPrice => _price!;

  @override
  String get getMapStyle => _mapStyle!;

  @override
  LatLng get getPickupLocation => _pickupLocation;

  @override
  LatLng get getDestinationLocation => _destinationLocation;

  @override
  set setTripType(TripType tripType) {
    _tripType = tripType;
    _setPageContent();
    emit(ChangeVehicleTypeState());
  }

  @override
  set setPrice(String? price) {
    try {
      _price = int.parse(price!);
    } catch (e) {
      _price = _recommendedPrice;
    }
    _setPageContent();
  }

  @override
  set setSelectedDriver(TripDriverModel? selectedDriver) {
    _selectedDriver = selectedDriver;
    _setPageContent();
    emit(SelectDriverState());
  }

  @override
  set setCanPop(bool canPop) {
    _canPop = canPop;
  }

  Future<void> _fetchMapStyle() async {
    emit(LoadingState());
    _mapStyle = await rootBundle.loadString('assets/maps/dark_map.json');
    emit(ContentState());
  }

  void _setPageContent() async {
    Widget res;
    switch (_pageIndex) {
      case -1:
        res = const TripLoading();
        break;
      case 0:
        res = TripVehicle();
        break;
      case 1:
        if (_recommendedPrice == null) {
          await _calculateDetails();
        }
        res = const TripConfirm();
        break;
      case 2:
        res = TripPrice();
        break;
      case 3:
        if (_driversStream == null) {
          await _findDrivers();
        }
        res = TripDriver();
        break;
      case 4:
        res = const TripDetails();
        break;
      default:
        res = const TripConfirm();
        break;
    }
    _pageContent = res;
    emit(ChangePageState());
  }

  nextPage() async {
    _canPop = false;
    if (_pageIndex < 4) {
      _pageIndex += 1;
      _setPageContent();
    }
  }

  prevPage() async {
    if (_pageIndex != -1) {
      if (_pageIndex == 3 && _driversStream != null) {
        await cancelTrip();
      }
      if (_pageIndex == 1) {
        _canPop = true;
      }
      if (_pageIndex > 0 && _pageIndex < 4) {
        _pageIndex -= 1;
        _setPageContent();
      }
    }
  }

  Future<void> cancelTrip() async {
    _loadingContent();
    await _cancelTripUseCase(
      CancelTripUseCaseInput(
        tripId: _tripId!,
      ),
    ).then(
      (value) {
        value.fold(
          (l) {
            emit(ErrorState(failure: l));
          },
          (r) {
            _driversStream = null;
            _tripId = null;
          },
        );
      },
    );
  }

  void _loadingContent() {
    int tmp = _pageIndex;
    _pageIndex = -1;
    _setPageContent();
    _pageIndex = tmp;
  }

  Future<void> _calculateDetails() async {
    _loadingContent();
    await _calculateTwoPointsUseCase(CalculateTwoPointsUseCaseInput(
            pointA: _pickupLocation, pointB: _destinationLocation))
        .then(
      (value) {
        value.fold(
          (l) {
            emit(ErrorState(
              failure: l,
              displayType: DisplayType.popUpDialog,
            ));
          },
          (r) {
            _tripExpectedTime = r['time'];
            _tripDistance = r['distance'];
            _recommendedPrice = _tripExpectedTime! * 3;
            _price = _recommendedPrice;
            emit(ContentState());
          },
        );
      },
    );
  }

  Future<void> _findDrivers() async {
    _loadingContent();
    await _findDriversUseCase(
      FindDriversUseCaseInput(
        passengerId: _userManager.getCurrentPassenger!.uuid,
        tripType: _tripType!,
        pickupLocation: _pickupLocation,
        destinationLocation: _destinationLocation,
        price: _price!,
        expectedTime: _tripExpectedTime!,
        distance: _tripDistance!,
      ),
    ).then(
      (value) {
        value.fold(
          (l) {
            emit(ErrorState(failure: l, displayType: DisplayType.popUpDialog));
          },
          (r) {
            _driversStream = r.$1;
            _tripId = r.$2;
          },
        );
      },
    );
  }

  Future<void> acceptDriver() async {
    _loadingContent();
    await _acceptDriversUseCase(
      AcceptDriverUseCaseInput(
        tripId: _tripId!,
        driverId: _selectedDriver!.id,
        price: _selectedDriver!.price,
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
            nextPage();
            r.whenComplete(
              () {
                DataIntent.pushRatedUserId(_selectedDriver!.id);
                emit(RateDriverState());
              },
            );
          },
        );
      },
    );
  }

  Future<void> shareTrip() async {
    Position userLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    Share.share('''
      Follow my trip details:\n
      Driver Name: ${_selectedDriver!.name}\n
      Driver Phone Number: ${_selectedDriver!.phoneNumber}\n
      Driver Car Model: ${_selectedDriver!.car}\n
      Driver Car Color: ${_selectedDriver!.color}\n
      Driver Car Licence: ${_selectedDriver!.license}\n
      Trip Type: ${_tripType!.name}\n
      Pickup Location: ${_pickupLocation.latitude}, ${_pickupLocation.longitude}\n
      Current Location: ${userLocation.latitude}, ${userLocation.longitude}\n
      Destination Location ${_destinationLocation.latitude}, ${_destinationLocation.longitude}\n
      ''');
  }
}

abstract class PassengerTripViewModelInput {
  set setTripType(TripType tripType);

  set setSelectedDriver(TripDriverModel? selectedDriver);

  set setPrice(String? price);

  set setCanPop(bool canPop);
}

abstract class PassengerTripViewModelOutput {
  Widget? get getPage;

  TripType? get getTripType;

  int get getPageIndex;

  TripDriverModel get getSelectedDriver;

  List<String> get getDriversIds;

  Stream<List<Future<TripDriverModel>>> get getDrivers;

  bool get getCanPop;

  TextEditingController get getPriceController;

  int get getPrice;

  String get getMapStyle;

  LatLng get getPickupLocation;

  LatLng get getDestinationLocation;
}
