import 'dart:io';

import 'package:speedy_go/presentation/base/base_states.dart';

class RegisterPassengerState extends BaseStates {}

class RegisterCarState extends BaseStates {}

class RegisterTukTukState extends BaseStates {}

class RegisterBusState extends BaseStates {}

class RegisterVehicleSelectionState extends BaseStates {}

class RegisterImagePickedState extends BaseStates {
  RegisterImagePickedState({
    required this.image,
  });

  final File image;
}

class RegisterVerifyPhoneNumberState extends BaseStates {}
