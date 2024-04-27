import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:speedy_go/presentation/base/base_cubit.dart';

import '../../base/base_states.dart';
import '../states/permissions_states.dart';

class PermissionsViewModel extends BaseCubit
    implements PermissionsViewModelInput, PermissionsViewModelOutput {
  static PermissionsViewModel get(context) => BlocProvider.of(context);

  LocationPermission _locationPermissions = LocationPermission.denied;

  bool _canPop = false;

  @override
  void start() {
    _checkLocationServices();
  }

  Future<void> _checkLocationServices() async {
    emit(LoadingState());
    Geolocator.getServiceStatusStream().listen((status) async {
      if (status == ServiceStatus.disabled) {
        emit(LocationServiceDisabledState());
      } else {
        await _checkLocationPermissions();
      }
    });
    if (await Geolocator.isLocationServiceEnabled()) {
      await _checkLocationPermissions();
    } else {
      emit(LocationServiceDisabledState());
    }
  }

  Future<void> askForLocationServices() async {
    await Geolocator.openLocationSettings();
  }

  Future<void> _checkLocationPermissions() async {
    _locationPermissions = await Geolocator.checkPermission();
    if (_locationPermissions == LocationPermission.denied) {
      emit(LocationPermissionsDisabledState());
    } else if (_locationPermissions == LocationPermission.deniedForever) {
      emit(LocationPermissionsDisabledState());
    } else {
      _canPop = true;
      emit(AllPermissionsGrantedState());
    }
  }

  Future<void> askForLocationPermissions() async {
    if (_locationPermissions != LocationPermission.deniedForever) {
      LocationPermission permissions = await Geolocator.requestPermission();
      if (permissions == LocationPermission.deniedForever) {
        _locationPermissions = permissions;
      } else {
        await _checkLocationPermissions();
      }
    } else {
      await Geolocator.openAppSettings();
      await _checkLocationPermissions();
    }
  }

  @override
  bool get getCanPop => _canPop;
}

abstract class PermissionsViewModelInput {}

abstract class PermissionsViewModelOutput {
  bool get getCanPop;
}
