import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/domain/usecase/add_bus_usecase.dart';
import 'package:uuid/uuid.dart';

import '../../../../base/base_cubit.dart';
import '../../../../base/base_states.dart';

class AddBusViewModel extends BaseCubit
    implements PassengerTripViewModelInput, PassengerTripViewModelOutput {
  static AddBusViewModel get(context) => BlocProvider.of(context);

  final AddBusUseCase _addBusUseCase;
  AddBusViewModel(this._addBusUseCase);

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _nationalIDController;
  late final TextEditingController _seatsNumberController;
  late final TextEditingController _numberOfBusController;
  late final TextEditingController _priceController;
  late final TextEditingController _pickupLocationController;
  late final TextEditingController _destinationLocationController;
  DateTime? _calendar;
  File? _busLicense;
  File? _drivingLicense;
  File? _busImage;

  late String driverId;

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

  // Future<void> addBusTrip() async {
  //   await _addBusTripUseCase(
  //     AddBusTripUseCaseInput(
  //       driverId,
  //       getNumberOfBusController.text as int,
  //       getPriceController.text as double,
  //       getPickupLocationController.text,
  //       getDestinationLocationController.text,
  //       getCalendar,
  //     ),
  //   ).then(
  //     (value) => {
  //       value.fold(
  //         (l) => emit(
  //           ErrorState(
  //             failure: l,
  //             displayType: DisplayType.popUpDialog,
  //           ),
  //         ),
  //         (r) {},
  //       ),
  //     },
  //   );
  // }

  Future<void> addBus() async {
    await _addBusUseCase(
      AddBusUseCaseInput(
        driverId,
        _uuidGenerator.v1(),
        getFirstNameController.text,
        getLastNameController.text,
        getBusLicense!,
        getDrivingLicense!,
        getNationalIDController.text,
        getPhoneNumberController.text,
        getBusImage!,
        getSeatsNumberController.text as int,
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
  File? get getBusImage => _busImage;

  @override
  File? get getBusLicense => _busLicense;

  @override
  File? get getDrivingLicense => _drivingLicense;

  @override
  TextEditingController get getFirstNameController => _firstNameController;

  @override
  TextEditingController get getLastNameController => _lastNameController;

  @override
  TextEditingController get getNationalIDController => _nationalIDController;

  @override
  TextEditingController get getPhoneNumberController => _phoneNumberController;

  @override
  TextEditingController get getSeatsNumberController => _seatsNumberController;

  @override
  DateTime? get getCalendar => _calendar;

  @override
  TextEditingController get getDestinationLocationController =>
      _destinationLocationController;

  @override
  TextEditingController get getPickupLocationController => _pickupLocationController;

  @override
  TextEditingController get getNumberOfBusController => _numberOfBusController;

  @override
  TextEditingController get getPriceController => _priceController;
}

abstract class PassengerTripViewModelInput {}

abstract class PassengerTripViewModelOutput {
  TextEditingController get getFirstNameController;
  TextEditingController get getLastNameController;
  TextEditingController get getPhoneNumberController;
  TextEditingController get getNationalIDController;
  TextEditingController get getSeatsNumberController;
  TextEditingController get getNumberOfBusController;
  TextEditingController get getPriceController;
  TextEditingController get getPickupLocationController;
  TextEditingController get getDestinationLocationController;
  DateTime? get getCalendar;
  File? get getBusLicense;
  File? get getDrivingLicense;
  File? get getBusImage;
}
