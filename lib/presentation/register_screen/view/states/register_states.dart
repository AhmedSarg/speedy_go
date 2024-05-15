import 'dart:io';

import 'package:speedy_go/presentation/base/base_states.dart';

class RegisterPassengerState extends BaseStates {}

class RegisterCarState extends BaseStates {}

class PickFileState extends BaseStates {}

class RegisterTukTukState extends BaseStates {}

class RegisterBusState extends BaseStates {}

class RegisterVehicleSelectionState extends BaseStates {}

class RegisterImagePickSuccessState extends BaseStates {
  RegisterImagePickSuccessState({
    required this.image,
  });

  final File image;
}

class RegisterImagePickFailedState extends ErrorState {
  RegisterImagePickFailedState({
    required super.failure,
    super.displayType,
  });
}

class RegisterVerifyPhoneNumberState extends BaseStates {}

class RegisterTypeSelectionState extends BaseStates {}
