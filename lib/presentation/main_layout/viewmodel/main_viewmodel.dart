import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speedy_go/presentation/base/base_cubit.dart';
import 'package:speedy_go/presentation/base/base_states.dart';

import '../states/main_states.dart';

class MainViewModel extends BaseCubit
    implements MainViewModelInput, MainViewModelOutput {
  static MainViewModel get(context) => BlocProvider.of(context);

  late final PageController _pageController = PageController();

  LocationPermission _locationPermissions = LocationPermission.denied;

  late final GoogleMapController _mapController;
  LatLng? _userLocation;
  String? _mapStyle;

  Future<void> _fetchMapStyle() async {
    _mapStyle = await rootBundle.loadString('assets/maps/dark_map.json');
  }

  Future<void> _checkLocationServices() async {
    emit(LoadingState());
    Geolocator.getServiceStatusStream().listen((status) async {
      print(2.2);
      if (status == ServiceStatus.disabled) {
        print(2.3);
        emit(LocationServiceDisabledState());
      } else {
        print(2.4);
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
    }
    else {
      _permissionsPermitted();
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

  Future<void> _fetchUserLocation() async {
    Position currentPosition = await Geolocator.getCurrentPosition();
    _userLocation = LatLng(currentPosition.latitude, currentPosition.longitude);
    Geolocator.getPositionStream().listen((position) {
      _userLocation = LatLng(position.latitude, position.longitude);
    });
  }

  Future<void> _permissionsPermitted() async {
    emit(LoadingState());
    if (_userLocation == null) {
      await _fetchUserLocation();
    }
    if (_mapStyle == null) {
      await _fetchMapStyle();
    }
    emit(ContentState());
  }

  @override
  void start() async {
    await _checkLocationServices();
  }

  @override
  set setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  @override
  PageController get getPageController => _pageController;

  @override
  GoogleMapController get getMapController => _mapController;

  @override
  LatLng get getUserLocation => _userLocation!;

  @override
  String get getMapStyle => _mapStyle!;
}

abstract class MainViewModelInput {
  set setMapController(GoogleMapController mapController);
}

abstract class MainViewModelOutput {
  PageController get getPageController;

  GoogleMapController get getMapController;

  LatLng get getUserLocation;

  String get getMapStyle;
}
