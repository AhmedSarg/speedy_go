import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../app/sl.dart';
import '../../../domain/models/domain.dart';
import '../../../domain/models/user_manager.dart';
import '../../../domain/usecase/history_bus_current_trips_usecase.dart';
import '../../../domain/usecase/history_bus_past_trips_usecase.dart';
import '../../../domain/usecase/logout_usecase.dart';
import '../../base/base_cubit.dart';
import '../../base/base_states.dart';
import '../../buses_screen/states/buses_states.dart';
import '../states/main_states.dart';

class MainViewModel extends BaseCubit
    implements MainViewModelInput, MainViewModelOutput {
  static MainViewModel get(context) => BlocProvider.of(context);

  late final PageController _pageController = PageController();
  final UserManager _userManager = sl<UserManager>();
  final LogoutUseCase _logoutUseCase;
  GoogleMapController? _mapController;
  LatLng? _userLocation;
  String? _mapStyle;
  late String _name;
  late String _imagePath;

  late UserModel _userModel;
  final HistoryBusCurrentTripsUseCase _historyBusCurrentTripsUseCase =
      sl<HistoryBusCurrentTripsUseCase>();
  final HistoryBusPastTripsUseCase _historyBusPastTripsUseCase =
      sl<HistoryBusPastTripsUseCase>();

  MainViewModel(this._logoutUseCase);

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

  @override
  void start() async {
    _name = _userManager.getCurrentPassenger!.firstName;
    _imagePath = _userManager.getCurrentPassenger!.imagePath;
    emit(LoadingState());

    Future.delayed(const Duration(milliseconds: 100), () {
      emit(CheckLocationPermissionsState());
      emit(LoadingState());
    });
  }

  Future<void> logout() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    await _logoutUseCase.call(null).then(
      (value) {
        value.fold(
          (l) {
            emit(
              ErrorState(
                failure: l,
                displayType: DisplayType.popUpDialog,
              ),
            );
          },
          (r) {
            emit(LogoutState());
          },
        );
      },
    );
  }

  @override
  String get getName => _name;

  @override
  String get getImagePath => _imagePath;

  @override
  set setMapController(GoogleMapController mapController) {
    if (_mapController == null) {
      _mapController = mapController;
    } else {
      print('_____________mapController is already initialized');
    }
  }

  @override
  PageController get getPageController => _pageController;

  @override
  GoogleMapController get getMapController => _mapController!;

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

  String get getName;

  String get getImagePath;
}
