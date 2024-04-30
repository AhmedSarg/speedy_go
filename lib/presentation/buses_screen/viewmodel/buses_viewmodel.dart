import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/usecase/add_bus_usecase.dart';
import '../../base/base_cubit.dart';
import '../../base/base_states.dart';

class BusesViewModel extends BaseCubit
    implements PassengerTripViewModelInput, PassengerTripViewModelOutput {
  static BusesViewModel get(context) => BlocProvider.of(context);

  final AddBusUseCase _addBusUseCase;
  BusesViewModel(this._addBusUseCase);

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _nationalIDController;
  late final File _busLicense;
  late final File _drivingLicense;
  late final File _busImage;
  late final TextEditingController _seatsNumberController;
  late String driverId; //TODO: get from auth

  final Uuid _uuidGenerator = const Uuid();

  @override
  void start() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _nationalIDController = TextEditingController();
    _seatsNumberController = TextEditingController();
  }

  Future<void> addBus() async {
    await _addBusUseCase(AddBusUseCaseInput(
            driverId, //get driver id
            _uuidGenerator.v1(),
            getFirstNameController,
            getLastNameController,
            getBusLicense,
            getDrivingLicense,
            getNationalIDController,
            getPhoneNumberController,
            getBusImage,
            getSeatsNumberController as int))
        .then((value) => {
              value.fold(
                  (l) => emit(
                        ErrorState(
                          failure: l,
                          displayType: DisplayType.popUpDialog,
                        ),
                      ),
                  (r) {}),
            });
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
}

abstract class PassengerTripViewModelInput {}

abstract class PassengerTripViewModelOutput {
  String get getFirstNameController;
  String get getLastNameController;
  String get getPhoneNumberController;
  String get getNationalIDController;
  File get getBusLicense;
  File get getDrivingLicense;
  File get getBusImage;
  String get getSeatsNumberController;
}
