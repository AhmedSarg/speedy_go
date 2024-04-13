import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speedy_go/domain/models/enums.dart';
import 'package:speedy_go/presentation/base/base_states.dart';

import '../../base/base_cubit.dart';
import '../states/passenger_map_states.dart';

class PassengerMapViewModel extends BaseCubit
    implements PassengerMapViewModelInput, PassengerMapViewModelOutput {
  static PassengerMapViewModel get(context) => BlocProvider.of(context);

  LocationPermission _locationPermissions = LocationPermission.denied;

  late LatLng _userLocation;

  late String _mapStyle;

  late GoogleMapController _mapController;

  void goToMap(LocationMapType locationMapType) {
    emit(LocationMapState(locationMapType));
  }

  void exitMap() {
    emit(ContentState());
  }

  Future<void> fetchMapStyle() async {
    _mapStyle = await rootBundle.loadString('assets/maps/dark_map.json');
    emit(ContentState());
  }

  Future<void> _checkLocationServices() async {
    emit(LoadingState());
    Geolocator.getServiceStatusStream().listen((status) {
      if (status == ServiceStatus.disabled) {
        emit(LocationServiceDisabledState());
      } else {
        _checkLocationPermissions();
      }
    });
    if (await Geolocator.isLocationServiceEnabled()) {
      _checkLocationPermissions();
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
      fetchUserLocation();
      emit(ContentState());
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

  fetchUserLocation() async {
    Position currentPosition = await Geolocator.getCurrentPosition();
    _userLocation = LatLng(currentPosition.latitude, currentPosition.longitude);
    Geolocator.getPositionStream().listen((position) {
      _userLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  void start() async {
    await _checkLocationServices();
    await fetchMapStyle();
  }

  @override
  LatLng get getUserLocation => _userLocation;

  @override
  String get getMapStyle => _mapStyle;

  @override
  GoogleMapController get getMapController => _mapController;

  @override
  set setMapController(GoogleMapController controller) {
    _mapController = controller;
  }
}

abstract class PassengerMapViewModelInput {
  set setMapController(GoogleMapController controller);
}

abstract class PassengerMapViewModelOutput {
  LatLng get getUserLocation;
  String get getMapStyle;
  GoogleMapController get getMapController;
}
