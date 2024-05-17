import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/domain/models/user_manager.dart';
import 'package:speedy_go/domain/usecase/add_bus_usecase.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../app/functions.dart';
import '../../../../../../app/sl.dart';
import '../../../../../../data/network/failure.dart';
import '../../../../../base/base_cubit.dart';
import '../../../../../base/base_states.dart';
import '../states/add_bus_states.dart';

class AddBusViewModel extends BaseCubit
    implements PassengerTripViewModelInput, PassengerTripViewModelOutput {
  static AddBusViewModel get(context) => BlocProvider.of(context);

  final AddBusUseCase _addBusUseCase;
  final UserManager _userManager = sl<UserManager>();

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
  late final TextEditingController _busPlateController;
  DateTime? _calendar;
  File? _busLicense;
  File? _drivingLicense;
  File? _busImage;

  late String _driverId;

  final Uuid _uuidGenerator = const Uuid();

  Future<void> addBus() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    _driverId = _userManager.getCurrentDriver!.uuid;
    await _addBusUseCase(
      AddBusUseCaseInput(
        driverId: _driverId,
        busId: _uuidGenerator.v1(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        phoneNumber: _phoneNumberController.text.trim(),
        nationalID: _nationalIDController.text.trim(),
        busLicense: _busLicense!,
        drivingLicense: _drivingLicense!,
        busImage: _busImage!,
        seatsNumber: int.parse(_seatsNumberController.text),
        busPlate: _busPlateController.text.trim(),
        busNumber: _userManager.getCurrentDriver!.buses!.length + 1,
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
          (r) {
            emit(
              SuccessState(message: 'Bus Added Successfully'),
            );
          },
        ),
      },
    );
  }

  void chooseBusLicenseFile() async {
    try {
      String path = await getImagesFromGallery();
      _busLicense = File(path);
      emit(AddBusImagePickedSuccessfully(image: _busLicense!));
    } catch (e) {
      emit(
        ErrorState(
          failure: Failure.fake(
            (e as Exception).toString(),
          ),
          displayType: DisplayType.popUpDialog,
        ),
      );
    }
  }

  void chooseDrivingLicenseFile() async {
    try {
      String path = await getImagesFromGallery();
      _drivingLicense = File(path);
      emit(AddBusImagePickedSuccessfully(image: _drivingLicense!));
    } catch (e) {
      emit(
        ErrorState(
          failure: Failure.fake(
            (e as Exception).toString(),
          ),
          displayType: DisplayType.popUpDialog,
        ),
      );
    }
  }

  void chooseBusImageFile() async {
    try {
      String path = await getImagesFromGallery();
      _busImage = File(path);
      emit(AddBusImagePickedSuccessfully(image: _busImage!));
    } catch (e) {
      emit(
        ErrorState(
          failure: Failure.fake(
            (e as Exception).toString(),
          ),
          displayType: DisplayType.popUpDialog,
        ),
      );
    }
  }

  clear() {
    _firstNameController.clear();
    _lastNameController.clear();
    _phoneNumberController.clear();
    _nationalIDController.clear();
    _busPlateController.clear();
    _drivingLicense = null;
    _busLicense = null;
    _busImage = null;
  }

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
    _busPlateController = TextEditingController();
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
  TextEditingController get getBusPlateController => _busPlateController;

  @override
  TextEditingController get getPickupLocationController =>
      _pickupLocationController;

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

  TextEditingController get getBusPlateController;

  DateTime? get getCalendar;

  File? get getBusLicense;

  File? get getDrivingLicense;

  File? get getBusImage;
}
