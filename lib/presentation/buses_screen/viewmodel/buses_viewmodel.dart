import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/usecase/add_bus_usecase.dart';
import '../../../domain/usecase/add_trip_bus.dart';
import '../../base/base_cubit.dart';
import '../../base/base_states.dart';

class BusesViewModel extends BaseCubit
    implements PassengerTripViewModelInput, PassengerTripViewModelOutput {
  static BusesViewModel get(context) => BlocProvider.of(context);

  final AddBusUseCase _addBusUseCase;
  final AddBusTripUseCase _addBusTripUseCase;
  BusesViewModel(this._addBusUseCase, this._addBusTripUseCase);

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _nationalIDController;
  late final TextEditingController _seatsNumberController;
  late final TextEditingController _numberOfBusController;
  late final TextEditingController _priceController;
  late final TextEditingController _pickupLocationController;
  late final TextEditingController _destinationLocationController;
  late final DateTime _calendar;
  late final File _busLicense;
  late final File _drivingLicense;
  late final File _busImage;

  late String driverId; //TODO: get from auth

  final Uuid _uuidGenerator = const Uuid();

  @override
  void start() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _nationalIDController = TextEditingController();
    _seatsNumberController = TextEditingController();
    _numberOfBusController = TextEditingController();
    _priceController = TextEditingController();
    _pickupLocationController = TextEditingController();
    _destinationLocationController = TextEditingController();
  }

  Future<void> addBusTrip() async {
    await _addBusTripUseCase(
      AddBusTripUseCaseInput(
        driverId,
        getNumberOfBusController,
        getPriceController,
        getPickupLocationController,
        getDestinationLocationController,
        getCalendar,
      ),
    ).then(
      (value) => {
        value.fold(
          (l) => emit(
            ErrorState(
              failure: l,
              displayType: DisplayType.popUpDialog,
            ),
          ),
          (r) {},
        ),
      },
    );
  }

  Future<void> addBus() async {
    await _addBusUseCase(
      AddBusUseCaseInput(
        driverId, //get driver id
        _uuidGenerator.v1(),
        getFirstNameController,
        getLastNameController,
        getBusLicense,
        getDrivingLicense,
        getNationalIDController,
        getPhoneNumberController,
        getBusImage,
        getSeatsNumberController as int,
      ),
    ).then(
      (value) => {
        value.fold(
          (l) => emit(
            ErrorState(
              failure: l,
              displayType: DisplayType.popUpDialog,
            ),
          ),
          (r) {},
        ),
      },
    );
  }

  @override
  File get getBusImage => _busImage;

  @override
  File get getBusLicense => _busLicense;

  @override
  File get getDrivingLicense => _drivingLicense;

  @override
  String get getFirstNameController => _firstNameController.text;

  @override
  String get getLastNameController => _lastNameController.text;

  @override
  String get getNationalIDController => _nationalIDController.text;

  @override
  String get getPhoneNumberController => _phoneNumberController.text;

  @override
  String get getSeatsNumberController => _seatsNumberController.text;

  @override
  DateTime get getCalendar => _calendar;

  @override
  String get getDestinationLocationController =>
      _destinationLocationController.text;

  @override
  String get getPickupLocationController => _pickupLocationController.text;

  @override
  int get getNumberOfBusController => _numberOfBusController.text as int;

  @override
  double get getPriceController => _priceController.text as double;
}

abstract class PassengerTripViewModelInput {}

abstract class PassengerTripViewModelOutput {
  String get getFirstNameController;
  String get getLastNameController;
  String get getPhoneNumberController;
  String get getNationalIDController;
  String get getSeatsNumberController;
  int get getNumberOfBusController;
  double get getPriceController;
  String get getPickupLocationController;
  String get getDestinationLocationController;
  DateTime get getCalendar;
  File get getBusLicense;
  File get getDrivingLicense;
  File get getBusImage;
}
