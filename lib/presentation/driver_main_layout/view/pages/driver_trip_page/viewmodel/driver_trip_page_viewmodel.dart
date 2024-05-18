import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flexible_polyline_dart/flutter_flexible_polyline.dart';
import 'package:flexible_polyline_dart/latlngz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speedy_go/domain/models/enums.dart';
import 'package:speedy_go/domain/usecase/end_trip_usecase.dart';
import 'package:speedy_go/presentation/common/data_intent/data_intent.dart';

import '../../../../../../domain/models/domain.dart';
import '../../../../../../domain/models/user_manager.dart';
import '../../../../../../domain/usecase/accept_trip_usecase.dart';
import '../../../../../../domain/usecase/cancel_accept_trip_usecase.dart';
import '../../../../../../domain/usecase/change_driver_status_usecase.dart';
import '../../../../../../domain/usecase/find_trips_usecase.dart';
import '../../../../../base/base_cubit.dart';
import '../../../../../base/base_states.dart';
import '../../../../../common/widget/app_lifecycle_observer.dart';
import '../../../../../resources/assets_manager.dart';
import '../../../../../resources/color_manager.dart';
import '../../../../../resources/values_manager.dart';
import '../../../../states/driver_trip_states.dart';
import '../view/pages/accept_ride_page.dart';
import '../view/pages/loading_page.dart';
import '../view/pages/running_trip.dart';
import '../view/pages/trip_edit_cost.dart';
import '../view/pages/trip_finished_page.dart';

class DriverTripViewModel extends BaseCubit
    implements DriverTripViewModelInput, DriverTripViewModelOutput {
  static DriverTripViewModel get(context) => BlocProvider.of(context);

  final UserManager _userManager;
  final ChangeDriverStatusUseCase _changeDriverStatusUseCase;
  final FindTripsUseCase _findTripsUseCase;
  final AcceptTripUseCase _acceptTripUseCase;
  final CancelAcceptTripUseCase _cancelAcceptTripUseCase;
  final EndTripUseCase _endTripUseCase;

  DriverTripViewModel(
    this._userManager,
    this._changeDriverStatusUseCase,
    this._findTripsUseCase,
    this._acceptTripUseCase,
    this._cancelAcceptTripUseCase,
    this._endTripUseCase,
  );

  bool _driverStatus = false, _isAccepted = false, _started = false;

  String? _mapStyle;

  late GoogleMapController _mapController;

  final AppLifecycleObserver _appLifecycleObserver = AppLifecycleObserver();

  Stream<LatLng>? _positionStream;

  StreamSubscription<LatLng>? _positionSubscription;

  LatLng? _userLocation;

  final TextEditingController _costController = TextEditingController();

  int? _newCost;

  int _pageIndex = 0;

  Widget? _contentPage;

  Stream<List<(String, Future<TripPassengerModel>)>>? _tripsStream;

  final CarouselController _carouselController = CarouselController();

  final List<(String, Future<TripPassengerModel>)> _tripsList = [];

  TripPassengerModel? _selectedTrip;

  int _tripIndex = 0;

  Set<Polyline> _polyline = {};

  Set<Marker> _markers = {};

  final Set<int> _errorIndexes = {};

  final List<String> _tripsIds = [];

  bool _currentError = false;

  updatePage() {
    if (_pageIndex == -2) {
      _contentPage = const EditCost();
    } else if (_pageIndex == -1) {
      _contentPage = const DriverTripLoadingPage();
    } else if (_pageIndex == 0) {
      _contentPage = AcceptRide();
    } else if (_pageIndex == 1) {
      _contentPage = RunningTrip();
    } else if (_pageIndex == 2) {
      _contentPage = TripEnd();
    } else {
      _driverStatus = false;
    }
    emit(ChangePageState());
  }

  nextPage() {
    print('next clicked');
    if (_pageIndex < 2) {
      _pageIndex++;
      updatePage();
    }
  }

  reset() {
    print('RESET');
    _positionSubscription!.cancel();
    _selectedTrip = null;
    _tripIndex = 0;
    _errorIndexes.clear();
    _markers.clear();
    _polyline.clear();
    _tripsList.clear();
    _tripsIds.clear();
    _currentError = false;
    _isAccepted = false;
    _tripsStream = null;
    _pageIndex = 0;
    updatePage();
  }

  toggleChangeStatusDialog() {
    emit(ChangeDriverStatusState());
  }

  _getLocationStream() {
    emit(CheckPermissionsState());
    _positionStream = Geolocator.getPositionStream().map(
      (gPos) => LatLng(
        gPos.latitude,
        gPos.longitude,
      ),
    );
  }

  onLocationPermissionsSuccess() async {
    await _fetchUserLocation();
    await _fetchMapStyle();
  }

  Future<void> _fetchMapStyle() async {
    _mapStyle ??= await rootBundle.loadString('assets/maps/dark_map.json');
  }

  Future<void> _fetchUserLocation() async {
    emit(LoadingState());
    if (_userLocation == null) {
      Position position = await Geolocator.getCurrentPosition();
      _userLocation = LatLng(position.latitude, position.longitude);
    }
    emit(ContentState());
  }

  Future<void> toggleDriverStatus() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    _positionSubscription = _positionStream?.listen(null);
    await _changeDriverStatusUseCase(
      ChangeDriverStatusUseCaseInput(
        online: !_driverStatus,
        driverId: _userManager.getCurrentDriver!.uuid,
        coordinatesSubscription: _positionSubscription,
      ),
    ).then(
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
          (r) async {
            _driverStatus = !_driverStatus;
            if (!_driverStatus) {
              reset();
              _mapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _userLocation!,
                    zoom: AppSize.s18,
                  ),
                ),
              );
            } else {
              await findTrips();
            }
            emit(DriverStatusChangedState());
          },
        );
      },
    );
  }

  Future<void> findTrips() async {
    _started = false;
    TripType tripType;
    switch (_userManager.getCurrentDriver!.vehicleType) {
      case VehicleType.car:
        tripType = TripType.car;
        break;
      case VehicleType.tuktuk:
        tripType = TripType.tuktuk;
        break;
      case VehicleType.bus:
        tripType = TripType.car;
        break;
      default:
        tripType = TripType.car;
        break;
    }
    await _findTripsUseCase(
      FindTripsUseCaseInput(
        driverLocation: _userLocation!,
        tripType: tripType,
      ),
    ).then(
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
          (r) async {
            _tripsStream = r.map((newTripsListTuples) {
              List<String> newTripsIds = [];
              for ((String, Future<TripPassengerModel>) tuple
                  in newTripsListTuples) {
                if (!_tripsIds.contains(tuple.$1)) {
                  _tripsList.add(tuple);
                  _tripsIds.add(tuple.$1);
                }
                newTripsIds.add(tuple.$1);
              }
              List<String> removedTrips = [];
              for ((String, Future<TripPassengerModel>) oldListTuple
                  in _tripsList) {
                if (!newTripsIds.contains(oldListTuple.$1)) {
                  removedTrips.add(oldListTuple.$1);
                  if (oldListTuple.$1 == _selectedTrip?.id) {
                    _tripIndex = 0;
                  }
                }
              }
              _tripsList
                  .removeWhere((element) => removedTrips.contains(element.$1));
              if (!_started) {
                _tripsList[0].$2.then((v) async {
                  _selectedTrip = v;
                  await fetchPolylines();
                  updatePage();
                  emit(ContentState());
                });
              }
              return _tripsList;
            });
            await fetchPolylines();
            updatePage();
            emit(ContentState());
          },
        );
      },
    );
  }

  nextTrip() {
    _carouselController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  prevTrip() {
    _carouselController.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  goToEditCost() {
    int tmp = _pageIndex;
    _pageIndex = -2;
    updatePage();
    _pageIndex = tmp;
  }

  handleSelectedTrip(int tripIndex, _) async {
    _tripIndex = tripIndex;
    if (_currentError) {
      _errorIndexes.add(_tripIndex);
    } else {
      _errorIndexes.remove(_tripIndex);
    }
    _selectedTrip = await _tripsList[tripIndex].$2;
    await fetchPolylines();
    updatePage();
  }

  Future<void> acceptTrip([int? newPrice]) async {
    _isAccepted = true;
    _started = true;
    updatePage();
    await _acceptTripUseCase(
      AcceptTripUseCaseInput(
        tripId: _selectedTrip!.id,
        driverId: _userManager.getCurrentDriver!.uuid,
        price: newPrice ?? _selectedTrip!.price,
        location: (await getLocationName(_userLocation!)) ?? "Unknown Location",
        coordinates: _userLocation!,
      ),
    ).then(
      (value) {
        value.fold(
          (l) {
            _started = false;
            emit(
              ErrorState(
                failure: l,
                displayType: DisplayType.popUpDialog,
              ),
            );
          },
          (r) async {
            if (await r) {
              _started = true;
              print('in right');
              nextPage();
            } else {
              _isAccepted = false;
              _started = false;
              updatePage();
            }
          },
        );
      },
    );
  }

  Future<String?> getLocationName(LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
      if (placemarks.isNotEmpty) {
        for (Placemark placemark in placemarks) {
          if (placemark.name != null &&
              placemark.name!.isNotEmpty &&
              !placemark.name!.contains(RegExp(r'[0-9]')) &&
              !placemark.name!.contains('+')) {
            return placemark.name;
          }
        }
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error finding nearest popular place: $e');
      }
      return null;
    }
  }

  Future<void> cancelAcceptTrip() async {
    _started = false;
    _isAccepted = false;
    updatePage();
    await _cancelAcceptTripUseCase(
      CancelAcceptTripUseCaseInput(
        tripId: _selectedTrip!.id,
        driverId: _userManager.getCurrentDriver!.uuid,
      ),
    ).then(
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
          (r) async {
            await findTrips();
          },
        );
      },
    );
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

  fetchPolylines() async {
    _polyline.clear();
    _markers.clear();
    if (_selectedTrip != null) {
      List<LatLngZ> polylineMatrix =
          FlexiblePolyline.decode(_selectedTrip!.routeCode);
      List<LatLng> resultedPolylineMatrix = [];
      for (var polyline in polylineMatrix) {
        resultedPolylineMatrix.add(
          LatLng(
            polyline.lat,
            polyline.lng,
          ),
        );
      }
      _polyline = {
        Polyline(
          polylineId: const PolylineId("route"),
          points: resultedPolylineMatrix,
          color: ColorManager.secondary,
          width: 2,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
        ),
      };
      _markers = {
        Marker(
          markerId: const MarkerId('pickup_pin'),
          icon: await _bitmapDescriptorFromSvgAsset(SVGAssets.pin),
          position: _selectedTrip!.pickupLocation,
        ),
        Marker(
          markerId: const MarkerId('destination_pin'),
          icon: await _bitmapDescriptorFromSvgAsset(SVGAssets.pin),
          position: _selectedTrip!.destinationLocation,
        ),
      };
      LatLng sw = LatLng(
        min(
          _selectedTrip!.pickupLocation.latitude,
          _selectedTrip!.destinationLocation.latitude,
        ),
        min(
          _selectedTrip!.pickupLocation.longitude,
          _selectedTrip!.destinationLocation.longitude,
        ),
      );
      LatLng ne = LatLng(
        max(
          _selectedTrip!.pickupLocation.latitude,
          _selectedTrip!.destinationLocation.latitude,
        ),
        max(
          _selectedTrip!.pickupLocation.longitude,
          _selectedTrip!.destinationLocation.longitude,
        ),
      );
      _mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: sw,
            northeast: ne,
          ),
          AppSize.s100,
        ),
      );
    }
  }

  Future<void> endTrip() async {
    _newCost = null;
    _started = false;
    await _endTripUseCase(EndTripUseCaseInput(
      tripId: _selectedTrip!.id,
    )).then(
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
            nextPage();
          },
        );
      },
    );
  }

  ratePassenger() {
    DataIntent.pushRatedUserId(_selectedTrip!.passengerId);
    emit(RatePassengerState());
  }

  afterTrip() async {
    emit(LoadingState());
    reset();
    emit(LoadingState());
    await findTrips();
  }

  @override
  void start() {
    emit(LoadingState());
    _appLifecycleObserver.initialize(() {
      print(_selectedTrip);
      print(_started);
      if (_selectedTrip != null && _pageIndex == 0) {
        cancelAcceptTrip();
      }
    });
    Future.delayed(
      const Duration(milliseconds: 100),
      _getLocationStream,
    );
  }

  @override
  bool get getDriverStatus => _driverStatus;

  @override
  bool get getIsAccepted => _isAccepted;

  @override
  TextEditingController get getNewCostController => _costController;

  @override
  int get getTripPrice => _selectedTrip!.price;

  @override
  int get getPageIndex => _pageIndex;

  @override
  Widget? get getPage => _contentPage;

  @override
  String get getMapStyle => _mapStyle!;

  @override
  LatLng get getUserLocation => _userLocation!;

  @override
  Stream<List<(String, Future<TripPassengerModel>)>> get getTripsStream =>
      _tripsStream!;

  @override
  CarouselController get getCarouselController => _carouselController;

  @override
  int get getTripIndex => _tripIndex;

  @override
  List<(String, Future<TripPassengerModel>)> get getTripsList => _tripsList;

  @override
  TripPassengerModel get getSelectedTrip => _selectedTrip!;

  @override
  Set<Polyline> get getPolyline => _polyline;

  @override
  Set<Marker> get getMarkers => _markers;

  @override
  Set<int> get getErrorIndexes => _errorIndexes;

  @override
  int? get getNewCost => _newCost;

  @override
  set setTripPrice(int newPrice) {}

  @override
  set setMapController(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  set setCurrentError(bool error) {
    _currentError = error;
  }

  @override
  set setNewCost(int? newCost) {
    _newCost = newCost;
  }
}

abstract class DriverTripViewModelInput {
  set setTripPrice(int newPrice);

  set setMapController(GoogleMapController controller);

  set setCurrentError(bool error);

  set setNewCost(int? newCost);
}

abstract class DriverTripViewModelOutput {
  bool get getDriverStatus;

  bool get getIsAccepted;

  int get getPageIndex;

  TextEditingController get getNewCostController;

  int get getTripPrice;

  Widget? get getPage;

  String get getMapStyle;

  LatLng get getUserLocation;

  Stream<List<(String, Future<TripPassengerModel>)>> get getTripsStream;

  CarouselController get getCarouselController;

  int get getTripIndex;

  List<(String, Future<TripPassengerModel>)> get getTripsList;

  TripPassengerModel get getSelectedTrip;

  Set<Polyline> get getPolyline;

  Set<Marker> get getMarkers;

  Set<int> get getErrorIndexes;

  int? get getNewCost;
}
