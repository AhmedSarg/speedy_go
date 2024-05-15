import 'dart:io';

import 'package:speedy_go/presentation/base/base_states.dart';

class AddBusImagePickedSuccessfully extends BaseStates {
  final File image;

  AddBusImagePickedSuccessfully({required this.image});
}

class BusAfterSuccessState extends BaseStates {}