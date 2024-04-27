import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../domain/usecase/current_user_usecase.dart';
import '../../base/base_cubit.dart';
import '../../base/base_states.dart';
import '../states/main_states.dart';

class MainViewModel extends BaseCubit
    implements MainViewModelInput, MainViewModelOutput {
  static MainViewModel get(context) => BlocProvider.of(context);

  final CurrentUserUseCase _currentUserUseCase;

  MainViewModel(
    this._currentUserUseCase,
  );

  late final PageController _pageController = PageController();

  late final GoogleMapController _mapController;
  LatLng? _userLocation;
  String? _mapStyle;

  Future<void> _fetchMapStyle() async {
    _mapStyle = await rootBundle.loadString('assets/maps/dark_map.json');
  }

  Future<void> _fetchUserLocation() async {
    Position currentPosition = await Geolocator.getCurrentPosition();
    _userLocation = LatLng(currentPosition.latitude, currentPosition.longitude);
    Geolocator.getPositionStream().listen((position) {
      _userLocation = LatLng(position.latitude, position.longitude);
    });
  }

  Future<void> permissionsPermitted() async {
    emit(LoadingState());
    if (_mapStyle == null) {
      await _fetchMapStyle();
    }
    if (_userLocation == null) {
      await _fetchUserLocation();
    }
    emit(ContentState());
  }

  Future<void> _fetchUser() async {
    emit(LoadingState());
    _currentUserUseCase(null).then(
      (value) {
        value.fold(
          (l) {
            emit(ErrorState(failure: l));
          },
          (r) {},
        );
      },
    );
  }

  @override
  void start() async {
    emit(LoadingState());
    await _fetchUser();
    emit(CheckLocationPermissionsState());
    emit(LoadingState());
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
