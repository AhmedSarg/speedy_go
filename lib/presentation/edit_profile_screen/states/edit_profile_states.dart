import 'dart:io';

import '../../base/base_states.dart';

class PictureSelectedState extends BaseStates {
  final File image;

  PictureSelectedState({required this.image});
}