import 'package:speedy_go/domain/models/enums.dart';

import '../../base/base_states.dart';

class LocationServiceDisabledState extends BaseStates {}

class LocationPermissionsDisabledState extends BaseStates {}

class LocationMapState extends BaseStates {
  final LocationMapType locationMapType;

  LocationMapState(this.locationMapType);
}
