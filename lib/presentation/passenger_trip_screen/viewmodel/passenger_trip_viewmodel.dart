import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speedy_go/domain/usecase/calculate_two_points_usecase.dart';
import 'package:speedy_go/presentation/base/base_states.dart';

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
import '../view/pages/trip_search.dart';
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
  double? _tripExpectedTime;
  int? _tripDistance;
  final List<TripDriverModel> _drivers = [
    TripDriverModel(
      id: 1,
      name: 'Ahmed Sherief',
      location: 'Kafr El Sheikh',
      price: 50,
      phoneNumber: '01003557871',
      car: 'Toyota',
      color: 'Light Blue',
      license: 'ل م ط 554',
      rate: 5,
      numberOfRates: 0,
      time: 30,
    ),
    TripDriverModel(
      id: 2,
      name: 'Ali Walid',
      location: 'Kafr El Sheikh',
      price: 20,
      phoneNumber: '01003557872',
      car: 'Lancer Shark',
      color: 'Red',
      license: 'ل ث ق 433',
      rate: 4,
      numberOfRates: 0,
      time: 2,
    ),
    TripDriverModel(
      id: 3,
      name: 'Ahmed Sobhy',
      location: 'Shubra',
      price: 99,
      phoneNumber: '01003557873',
      car: 'Hyundai Elentra',
      color: 'Orange',
      license: 'ف ي م 986',
      rate: 2,
      numberOfRates: 0,
      time: 14,
    ),
  ];
  TripDriverModel? _selectedDriver;

  final TextEditingController _priceController = TextEditingController();

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
  List<TripDriverModel> get getDrivers => _drivers;

  @override
  bool get getCanPop => _canPop;

  @override
  TextEditingController get getPriceController => _priceController;

  @override
  set setTripType(TripType tripType) {
    _tripType = tripType;
    _setPageContent();
    emit(ChangeVehicleTypeState());
  }

  @override
  set setSelectedDriver(TripDriverModel selectedDriver) {
    _selectedDriver = selectedDriver;
    _setPageContent();
    emit(SelectDriverState());
  }

  void _setPageContent() {
    Widget res;
    switch (_pageIndex) {
      case 0:
        res = TripVehicle();
        break;
      case 1:
        res = const TripConfirm();
        break;
      case 2:
        res = const TripPrice();
        break;
      case 3:
        Future.delayed(const Duration(seconds: 2), () {
          nextPage();
        });
        res = const TripSearch();
        break;
      case 4:
        res = TripDriver();
        break;
      case 5:
        res = const TripDetails();
        break;
      default:
        res = const TripConfirm();
        break;
    }
    _pageContent = res;
    emit(ChangePageState());
  }

  nextPage() {
    _canPop = false;
    if (_pageIndex < 5) {
      _pageIndex += 1;
      _setPageContent();
    } else if (_pageIndex == 5) {
      emit(RateDriverState());
    }
  }

  prevPage() {
    if (_pageIndex == 1) {
      _canPop = true;
    }
    if (_pageIndex > 0) {
      _pageIndex -= 1;
      _setPageContent();
    }
  }

  Future<void> calculateDetails() async {
    emit(LoadingState());
    await _calculateTwoPointsUseCase(CalculateTwoPointsUseCaseInput(
            pointA: _pickupLocation, pointB: _destinationLocation))
        .then(
      (value) {
        value.fold(
          (l) {
            emit(ErrorState(failure: l));
          },
          (r) {
            _tripExpectedTime = r['time'];
            _tripDistance = r['distance'];
            _priceController.text = (_tripExpectedTime! * 3).toString();
            emit(ContentState());
          },
        );
      },
    );
  }

  Future<void> findDrivers() async {
    _findDriversUseCase(
      FindDriversUseCaseInput(
        passengerId: 'passengerId',
        tripType: _tripType!,
        pickupLocation: _pickupLocation,
        destinationLocation: _destinationLocation,
        price: int.parse(_priceController.text),
      ),
    );
  }
}

abstract class PassengerTripViewModelInput {
  set setTripType(TripType tripType);

  set setSelectedDriver(TripDriverModel selectedDriver);
}

abstract class PassengerTripViewModelOutput {
  Widget? get getPage;

  TripType? get getTripType;

  int get getPageIndex;

  TripDriverModel get getSelectedDriver;

  List<TripDriverModel> get getDrivers;

  bool get getCanPop;

  TextEditingController get getPriceController;
}
