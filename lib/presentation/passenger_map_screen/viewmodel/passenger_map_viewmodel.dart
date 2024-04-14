import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speedy_go/presentation/resources/assets_manager.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

import '../../../domain/models/enums.dart';
import '../../base/base_cubit.dart';
import '../../base/base_states.dart';
import '../states/passenger_map_states.dart';

class PassengerMapViewModel extends BaseCubit
    implements PassengerMapViewModelInput, PassengerMapViewModelOutput {
  static PassengerMapViewModel get(context) => BlocProvider.of(context);

  LocationPermission _locationPermissions = LocationPermission.denied;

  LatLng? _userLocation;
  LatLng? _pickupLocation;
  LatLng? _destinationLocation;

  String? _mapStyle;

  late LocationMapType _locationMapType;

  late GoogleMapController _mapController;

  BitmapDescriptor? _pin;

  Set<Marker> _pickupMarkers = {};
  Set<Marker> _destinationMarkers = {};

  void goToMap(LocationMapType locationMapType) async {
    emit(LoadingState());
    _locationMapType = locationMapType;
    if (_userLocation == null) {
      await _fetchUserLocation();
    }
    if (_mapStyle == null) {
      await _fetchMapStyle();
    }
    if (_pin == null) {
      await _fetchPinIcon();
    }
    emit(LocationMapState(locationMapType));
  }

  void exitMap() {
    emit(ContentState());
  }

  Future<void> _fetchMapStyle() async {
    _mapStyle = await rootBundle.loadString('assets/maps/dark_map.json');
  }

  Future<BitmapDescriptor> _bitmapDescriptorFromSvgAsset(
    String assetName, [
    Size size = const Size.square(AppSize.s60),
  ]) async {
    final pictureInfo = await vg.loadPicture(SvgAssetLoader(assetName), null);

    double devicePixelRatio =
        PlatformDispatcher.instance.views.first.devicePixelRatio;
    int width = (size.width * devicePixelRatio).toInt();
    int height = (size.height * devicePixelRatio).toInt();

    final scaleFactor = min(
      width / pictureInfo.size.width,
      height / pictureInfo.size.height,
    );

    final recorder = PictureRecorder();

    Canvas(recorder)
      ..scale(scaleFactor)
      ..drawPicture(pictureInfo.picture);

    final rasterPicture = recorder.endRecording();

    final image = rasterPicture.toImageSync(width, height);
    final bytes = (await image.toByteData(format: ImageByteFormat.png))!;

    return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
  }

  Future<void> _fetchPinIcon() async {
    _pin = await _bitmapDescriptorFromSvgAsset(SVGAssets.pin);
  }

  Future<void> chooseLocation(LatLng location) async {
    if (_locationMapType == LocationMapType.pickup) {
      _pickupLocation = location;
      _pickupMarkers = {
        Marker(
          markerId: const MarkerId('de'),
          position: location,
          icon: _pin!,
        ),
      };
    } else {
      _destinationLocation = location;
      _destinationMarkers = {
        Marker(
          markerId: const MarkerId('de'),
          position: location,
          icon: _pin!,
        ),
      };
    }
    emit(LocationMapState(_locationMapType));
  }

  bool canClickDone() {
    if (_locationMapType == LocationMapType.pickup) {
      return _pickupLocation != null;
    } else {
      return _destinationLocation != null;
    }
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

  Future<void> _fetchUserLocation() async {
    Position currentPosition = await Geolocator.getCurrentPosition();
    _userLocation = LatLng(currentPosition.latitude, currentPosition.longitude);
    Geolocator.getPositionStream().listen((position) {
      _userLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  void start() async {
    await _checkLocationServices();
  }

  @override
  LatLng get getUserLocation => _userLocation!;

  @override
  String get getMapStyle => _mapStyle!;

  @override
  GoogleMapController get getMapController => _mapController;

  @override
  Set<Marker> get getMarkers => _locationMapType == LocationMapType.pickup
      ? _pickupMarkers
      : _destinationMarkers;

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

  Set<Marker> get getMarkers;
}
