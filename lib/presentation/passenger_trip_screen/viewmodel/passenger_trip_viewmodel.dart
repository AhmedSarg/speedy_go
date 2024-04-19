import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speedy_go/domain/usecase/calculate_two_points_usecase.dart';
import 'package:speedy_go/presentation/base/base_states.dart';
import 'package:speedy_go/presentation/passenger_trip_screen/view/pages/trip_loading.dart';

import '../../../../../../domain/models/domain.dart';
import '../../../../../../domain/models/enums.dart';
import '../../../domain/usecase/find_drivers_usecase.dart';
import '../../base/base_cubit.dart';
import '../../common/data_intent/data_intent.dart';
import '../states/trip_states.dart';
import '../view/pages/trip_confirm.dart';
import '../view/pages/trip_details.dart';
import '../view/pages/trip_driver.dart';
import '../view/pages/trip_price.dart';
import '../view/pages/trip_vehicle.dart';

class PassengerTripViewModel extends BaseCubit
    implements PassengerTripViewModelInput, PassengerTripViewModelOutput {
  static PassengerTripViewModel get(context) => BlocProvider.of(context);

  final FindDriversUseCase _findDriversUseCase;
  final CalculateTwoPointsUseCase _calculateTwoPointsUseCase;

  PassengerTripViewModel(
      this._findDriversUseCase, this._calculateTwoPointsUseCase);

  int _pageIndex = 0;

  Widget? _pageContent;

  TripType? _tripType;

  bool _canPop = true;
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

  StreamSubscription<List<Future<TripDriverModel>>>? _driversSubscription;

  @override
  void start() {
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
  set setTripType(TripType tripType) {
    _tripType = tripType;
    _setPageContent();
    emit(ChangeVehicleTypeState());
  }
  @override
  set setPrice(String? price) {
    print(100);
    try {
      print(200);
      _price = int.parse(price!);
    } catch (e) {
      print(300);
      _price = _recommendedPrice;
    }
    print(4);
    _setPageContent();
  }

  @override
  set setSelectedDriver(TripDriverModel? selectedDriver) {
    _selectedDriver = selectedDriver;
    _setPageContent();
    emit(SelectDriverState());
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
        res = const TripConfirm();
        break;
      case 2:
        if (_recommendedPrice == null) {
          _loadingContent();
          await _calculateDetails();
        }
        res = TripPrice();
        _pageIndex = 2;
        break;
      case 3:
        if (_driversStream == null) {
          _loadingContent();
          await _findDrivers();
          _pageIndex = 3;
        }
        res = TripDriver();
        break;
      case 4:
        _driversSubscription!.cancel();
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
    } else if (_pageIndex == 4) {
      emit(RateDriverState());
    }
  }

  prevPage() {
    if (_pageIndex != -1) {
      if (_pageIndex == 3 && _driversStream != null) {
        //todo cancel trip
      }
      if (_pageIndex == 1) {
        _canPop = true;
      }
      if (_pageIndex > 0) {
        _pageIndex -= 1;
        _setPageContent();
      }
    }
  }

  void _loadingContent() {
    _pageIndex = -1;
    _setPageContent();
  }

  Future<void> _calculateDetails() async {
    await _calculateTwoPointsUseCase(CalculateTwoPointsUseCaseInput(
            pointA: _pickupLocation, pointB: _destinationLocation))
        .then(
      (value) {
        value.fold(
          (l) {
            emit(ErrorState(failure: l, displayType: DisplayType.popUpDialog,));
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

  //error state

  Future<void> _findDrivers() async {
    await _findDriversUseCase(
      FindDriversUseCaseInput(
        passengerId: 'passengerId',
        tripType: _tripType!,
        pickupLocation: _pickupLocation,
        destinationLocation: _destinationLocation,
        price: _price!,
      ),
    ).then(
      (value) {
        value.fold(
          (l) {
            emit(ErrorState(failure: l, displayType: DisplayType.popUpDialog));
          },
          (r) {
            _driversStream = r;
          },
        );
      },
    );
  }
}

abstract class PassengerTripViewModelInput {
  set setTripType(TripType tripType);

  set setSelectedDriver(TripDriverModel? selectedDriver);

  set setPrice(String? price);
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
}
