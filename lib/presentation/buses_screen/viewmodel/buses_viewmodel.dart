import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/usecase/add_bus_usecase.dart';
import '../../base/base_cubit.dart';

class BusesViewModel extends BaseCubit
    implements PassengerTripViewModelInput, PassengerTripViewModelOutput {
  static BusesViewModel get(context) => BlocProvider.of(context);

  final AddBusUseCase _addBusUseCase;
  BusesViewModel(this._addBusUseCase);

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _nationalIDController;
  late final TextEditingController _busLicenseController;
  late final TextEditingController _drivingLicenseController;
  late final TextEditingController _busImageController;
  late final TextEditingController _seatsNumberController;
  late String driverId;//TODO: get from auth

  final Uuid _uuidGenerator = const Uuid();

  @override
  void start() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _nationalIDController = TextEditingController();
    _busLicenseController = TextEditingController();
    _drivingLicenseController = TextEditingController();
    _busImageController = TextEditingController();
    _seatsNumberController = TextEditingController();
  }

  Future<void> addBus() async {
    await _addBusUseCase(
      AddBusUseCaseInput(
          driverId,//get driver id
          _uuidGenerator.v1(),
          getFirstNameController,
          getLastNameController,
          getBusLicenseController,
          getDrivingLicenseController,
          getNationalIDController,
          getPhoneNumberController,
          getBusImageController,
          getSeatsNumberController as int)
    );
  }

  @override
  String get getBusImageController => _busImageController.text;

  @override
  String get getBusLicenseController => _busLicenseController.text;

  @override
  String get getDrivingLicenseController => _drivingLicenseController.text;

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
  String get getBusLicenseController;
  String get getDrivingLicenseController;
  String get getBusImageController;
  String get getSeatsNumberController;
}
