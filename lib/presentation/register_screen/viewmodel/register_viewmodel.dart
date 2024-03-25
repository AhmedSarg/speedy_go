import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/resources/strings_manager.dart';

import '../../../domain/models/enums.dart';
import '../../base/base_cubit.dart';
import '../../base/base_states.dart';
import '../../common/data_intent/data_intent.dart';
import '../view/states/register_states.dart';

class RegisterViewModel extends BaseCubit
    implements RegisterViewModelInput, RegisterViewModelOutput {
  Selection _registerType = Selection.passenger;

  RegisterType _registerBoxType = RegisterType.passenger;

  late double _boxHeight;

  late List<Widget> _boxContent;

  static RegisterViewModel get(context) => BlocProvider.of(context);

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nationalIdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  late File _drivingLicense;
  late File _carLicense;
  late File _carImage;
  late File _tukTukImage;
  Gender? _gender;

  @override
  void start() {
    if (DataIntent.getSelection() == Selection.driver) {
      emit(RegisterVehicleSelectionState());
    } else {
      emit(RegisterPassengerState());
    }
  }

  @override
  Selection get getRegisterType => _registerType;

  @override
  RegisterType get getRegisterBoxType => _registerBoxType;

  @override
  double get getBoxHeight => _boxHeight;

  @override
  List<Widget> get getBoxContent => _boxContent;

  @override
  TextEditingController get getFirstNameController => _firstNameController;

  @override
  TextEditingController get getLastNameController => _lastNameController;

  @override
  TextEditingController get getPhoneNumberController => _phoneNumberController;

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
  File get getDrivingLicense => _drivingLicense;

  @override
  File get getCarLicense => _carLicense;

  @override
  File get getCarImage => _carImage;

  @override
  File get getTukTukImage => _tukTukImage;

  @override
  Gender? get getGender => _gender;

  @override
  set setRegisterType(Selection registerType) {
    _registerType = registerType;
    if (registerType == Selection.driver) {
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
    emit(ContentState());
  }

  @override
  set setBoxHeight(double value) {
    _boxHeight = value;
    emit(ContentState());
  }

  @override
  set setBoxContent(List<Widget> content) {
    _boxContent = content;
    emit(ContentState());
  }

  @override
  set setGender(String gender) {
    if (gender == AppStrings.registerScreenGenderFemale.tr()) {
      _gender = Gender.female;
    }
    else if (gender == AppStrings.registerScreenGenderMale.tr()) {
      _gender = Gender.male;
    }
    else {
      _gender = null;
    }
    print(_gender);
  }
}

abstract class RegisterViewModelInput {
  set setRegisterType(Selection registerType);

  set setRegisterBoxType(RegisterType registerBoxType);

  set setBoxHeight(double value);

  set setBoxContent(List<Widget> content);

  set setGender(String gender);
}

abstract class RegisterViewModelOutput {
  Selection get getRegisterType;

  RegisterType get getRegisterBoxType;

  double get getBoxHeight;

  List<Widget> get getBoxContent;

  TextEditingController get getFirstNameController;

  TextEditingController get getLastNameController;

  TextEditingController get getPhoneNumberController;

  TextEditingController get getPasswordController;

  TextEditingController get getConfirmPasswordController;

  TextEditingController get getNationalIdController;

  TextEditingController get getEmailController;

  File get getDrivingLicense;

  File get getCarLicense;

  File get getCarImage;

  File get getTukTukImage;

  Gender? get getGender;
}
