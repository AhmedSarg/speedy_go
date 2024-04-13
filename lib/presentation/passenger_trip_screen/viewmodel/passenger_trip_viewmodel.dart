import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../domain/models/domain.dart';
import '../../../../../../domain/models/enums.dart';
import '../../base/base_cubit.dart';
import '../states/trip_states.dart';
import '../view/pages/trip_confirm.dart';
import '../view/pages/trip_details.dart';
import '../view/pages/trip_driver.dart';
import '../view/pages/trip_location.dart';
import '../view/pages/trip_price.dart';
import '../view/pages/trip_search.dart';
import '../view/pages/trip_vehicle.dart';

class PassengerTripViewModel extends BaseCubit
    implements PassengerTripViewModelInput, PassengerTripViewModelOutput {
  static PassengerTripViewModel get(context) => BlocProvider.of(context);
  int _pageIndex = 0;
  Widget? _pageContent;
  TripType? _tripType;
  bool _canPop = true;
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
      time: 14,
    ),
  ];
  TripDriverModel? _selectedDriver;
  late int price = 50;
  TextEditingController newPrice = TextEditingController();

  @override
  void start() {
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
}
