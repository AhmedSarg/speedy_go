import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/functions.dart';
import '../../../data/network/error_handler.dart';
import '../../../data/network/failure.dart';
import '../../../domain/models/enums.dart';
import '../../../domain/usecase/authenticate_usecase.dart';
import '../../../domain/usecase/register_usecase.dart';
import '../../base/base_cubit.dart';
import '../../base/base_states.dart';
import '../../common/data_intent/data_intent.dart';
import '../../common/models/models.dart';
import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';
import '../view/states/register_states.dart';

class RegisterViewModel extends BaseCubit
    implements RegisterViewModelInput, RegisterViewModelOutput {
  final AuthenticateUseCase _authenticateUseCase;
  final RegisterUseCase _registerCarDriverUseCase;

  RegisterViewModel(
    this._authenticateUseCase,
    this._registerCarDriverUseCase,
  );

  int _selectionIndex = 0;

  final List<VehicleSelectionModel> _registerVehicleSelection = [
    VehicleSelectionModel(
      name: AppStrings.registerScreenSelectionCar,
      icon: SVGAssets.car,
    ),
    VehicleSelectionModel(
      name: AppStrings.registerScreenSelectionTukTuk,
      icon: SVGAssets.tuktuk,
    ),
    VehicleSelectionModel(
      name: AppStrings.registerScreenSelectionBus,
      icon: SVGAssets.bus,
    ),
  ];

  late UserType _registerType;

  UserType? _oldRegisterType;

  late RegisterType _registerBoxType = RegisterType.passenger;

  late List<Widget> _boxContent;

  late Widget _content;

  static RegisterViewModel get(context) => BlocProvider.of(context);

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nationalIdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _vehicleModelController = TextEditingController();
  final TextEditingController _vehicleColorController = TextEditingController();
  final TextEditingController _vehiclePlateController = TextEditingController();

  final List<String> _countryCodes = [
    '---',
    '+20',
    '+966',
  ];

  late String _countryCode;

  File? _drivingLicense;
  File? _carLicense;
  File? _carImage;
  File? _tukTukImage;
  Gender? _gender;

  @override
  void start() {
    _countryCode = _countryCodes[0];
    _registerType = DataIntent.getSelection();
    if (_registerType == UserType.driver) {
      emit(RegisterVehicleSelectionState());
    } else {
      emit(RegisterPassengerState());
    }
  }

  @override
  UserType get getRegisterType => _registerType;

  @override
  RegisterType get getRegisterBoxType => _registerBoxType;

  @override
  int get getSelectionIndex => _selectionIndex;

  @override
  List<VehicleSelectionModel> get getSelectionVehicles =>
      _registerVehicleSelection;

  @override
  List<Widget> get getBoxContent => _boxContent;

  @override
  Widget get getContent => _content;

  @override
  TextEditingController get getFirstNameController => _firstNameController;

  @override
  TextEditingController get getLastNameController => _lastNameController;

  @override
  TextEditingController get getPhoneNumberController => _phoneNumberController;

  @override
  String get getCountryCode => _countryCode;

  @override
  List<String> get getCountryCodes => _countryCodes;

  @override
  TextEditingController get getPasswordController => _passwordController;

  @override
  TextEditingController get getConfirmPasswordController =>
      _confirmPasswordController;

  @override
  TextEditingController get getNationalIdController => _nationalIdController;

  @override
  TextEditingController get getEmailController => _emailController;

  @override
  TextEditingController get getVehicleModelController =>
      _vehicleModelController;

  @override
  TextEditingController get getVehicleColorController =>
      _vehicleColorController;

  @override
  TextEditingController get getVehiclePlateController =>
      _vehiclePlateController;

  @override
  File? get getDrivingLicense => _drivingLicense;

  @override
  File? get getCarLicense => _carLicense;

  @override
  File? get getCarImage => _carImage;

  @override
  File? get getTukTukImage => _tukTukImage;

  @override
  Gender? get getGender => _gender;

  @override
  set setRegisterType(UserType registerType) {
    _oldRegisterType = _registerType;
    _registerType = registerType;
    if (registerType == UserType.driver) {
      emit(RegisterVehicleSelectionState());
    } else {
      setRegisterBoxType = RegisterType.passenger;
      emit(ContentState());
    }
  }

  @override
  set setRegisterBoxType(RegisterType registerBoxType) {
    _registerBoxType = registerBoxType;
    if (registerBoxType == RegisterType.car) {
      emit(RegisterCarState());
    } else if (registerBoxType == RegisterType.tuktuk) {
      emit(RegisterTukTukState());
    } else if (registerBoxType == RegisterType.bus) {
      emit(RegisterBusState());
    } else {
      emit(RegisterPassengerState());
    }
  }

  @override
  set setBoxContent(List<Widget> content) {
    _boxContent = content;
    emit(ContentState());
  }

  @override
  set setContent(Widget content) {
    _content = content;
  }

  @override
  set setGender(String gender) {
    if (gender == AppStrings.registerScreenGenderFemale.tr()) {
      _gender = Gender.female;
    } else if (gender == AppStrings.registerScreenGenderMale.tr()) {
      _gender = Gender.male;
    } else {
      _gender = null;
    }
  }

  @override
  set setCountryCode(String countryCode) {
    _countryCode = countryCode;
    setRegisterBoxType = _registerBoxType;
    emit(ContentState());
  }

  void animateToDriver() {
    if (_oldRegisterType != null) {
      _registerType = _oldRegisterType!;
      Future.delayed(const Duration(milliseconds: 10), () {
        _registerType = UserType.driver;
        emit(ContentState());
      });
    } else {}
  }

  void chooseDrivingLicense() async {
    try {
      String path = await getImagesFromGallery();
      _drivingLicense = File(path);
      // _drivingLicense = renameFile(_drivingLicense!, 'driving_license.jpg');
      emit(RegisterImagePickSuccessState(image: _drivingLicense!));
      _oldRegisterType = UserType.driver;
      setRegisterBoxType = _registerBoxType;
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

  void chooseCarLicense() async {
    try {
      String path = await getImagesFromGallery();
      _carLicense = File(path);
      // _carLicense = renameFile(_carLicense!, 'car_license.jpg');
      emit(RegisterImagePickSuccessState(image: _carLicense!));
      _oldRegisterType = UserType.driver;
      setRegisterBoxType = _registerBoxType;
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

  void chooseCarImage() async {
    try {
      String path = await getImagesFromGallery();
      _carImage = File(path);
      emit(RegisterImagePickSuccessState(image: _carImage!));
      _oldRegisterType = UserType.driver;
      setRegisterBoxType = _registerBoxType;
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

  void chooseTukTukImage() async {
    try {
      String path = await getImagesFromGallery();
      _tukTukImage = File(path);
      emit(RegisterImagePickSuccessState(image: _tukTukImage!));
      _oldRegisterType = UserType.driver;
      setRegisterBoxType = _registerBoxType;
    } catch (e) {
      emit(
        RegisterImagePickFailedState(
          failure: ErrorHandler.handle(e).failure,
          displayType: DisplayType.popUpDialog,
        ),
      );
    }
  }

  Future<void> authenticate() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    String phoneNumber =
        _countryCode + _phoneNumberController.text.substring(1);
    await _authenticateUseCase(
      AuthenticateUseCaseInput(
        email: _emailController.text.trim(),
        phoneNumber: phoneNumber.trim(),
      ),
    ).then((value) {
      value.fold(
        (l) {
          emit(ErrorState(failure: l, displayType: DisplayType.popUpDialog));
        },
        (r) {
          DataIntent.pushPhoneNumber(phoneNumber);
          DataIntent.pushEmail(_emailController.text.trim());
          DataIntent.pushPassword(_passwordController.text.trim());
          DataIntent.setAuthType(AuthType.register);
          DataIntent.setOnVerified(_register);
          emit(RegisterVerifyPhoneNumberState());
        },
      );
    });
  }

  Future<BaseStates> _register() async {
    BaseStates resultState = SuccessState(message: 'message');
    String phoneNumber =
        _countryCode + _phoneNumberController.text.substring(1);
    await _registerCarDriverUseCase(
      RegisterUseCaseInput(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        gender: _gender,
        phoneNumber: phoneNumber,
        email: _emailController.text.trim(),
        nationalId: _nationalIdController.text.trim() == ''
            ? null
            : _nationalIdController.text.trim(),
        vehicleModel: _vehicleModelController.text.trim() == ''
            ? null
            : _vehicleModelController.text.trim(),
        vehicleColor: _vehicleColorController.text.trim() == ''
            ? null
            : _vehicleColorController.text.trim(),
        vehiclePlate: _vehiclePlateController.text.trim() == ''
            ? null
            : _vehiclePlateController.text.trim(),
        drivingLicense: _drivingLicense,
        carLicense: _carLicense,
        carImage: _carImage,
        tukTukImage: _tukTukImage,
        registerType: _registerBoxType,
      ),
    ).then(
      (value) {
        value.fold(
          (l) {
            resultState =
                ErrorState(failure: l, displayType: DisplayType.popUpDialog);
          },
          (r) {
            resultState = SuccessState(
                message: AppStrings.verificationScreenRegisterSuccessMessage);
          },
        );
      },
    );
    return resultState;
  }

  indexHandle(int selection) {
    if (selection == 0) {
      _selectionIndex--;
    } else {
      _selectionIndex++;
    }
    _selectionIndex = (_selectionIndex > 0) ? _selectionIndex % 3 : 0;
    emit(RegisterVehicleSelectionState());
  }

  selectionCanceled() {
    if (_oldRegisterType != null) {
      setRegisterType = _oldRegisterType!;
      setRegisterBoxType = _registerBoxType;
    } else {
      emit(RegisterTypeSelectionState());
    }
  }
}

abstract class RegisterViewModelInput {
  set setRegisterType(UserType registerType);

  set setRegisterBoxType(RegisterType registerBoxType);

  set setBoxContent(List<Widget> content);

  set setContent(Widget content);

  set setCountryCode(String countryCode);

  set setGender(String gender);
}

abstract class RegisterViewModelOutput {
  UserType get getRegisterType;

  RegisterType get getRegisterBoxType;

  int get getSelectionIndex;

  List<VehicleSelectionModel> get getSelectionVehicles;

  List<Widget> get getBoxContent;

  Widget get getContent;

  TextEditingController get getFirstNameController;

  TextEditingController get getLastNameController;

  TextEditingController get getPhoneNumberController;

  String get getCountryCode;

  List<String> get getCountryCodes;

  TextEditingController get getPasswordController;

  TextEditingController get getConfirmPasswordController;

  TextEditingController get getNationalIdController;

  TextEditingController get getEmailController;

  TextEditingController get getVehicleModelController;

  TextEditingController get getVehicleColorController;

  TextEditingController get getVehiclePlateController;

  File? get getDrivingLicense;

  File? get getCarLicense;

  File? get getCarImage;

  File? get getTukTukImage;

  Gender? get getGender;
}
