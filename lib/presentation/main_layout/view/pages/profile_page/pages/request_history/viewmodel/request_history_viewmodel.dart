import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speedy_go/domain/models/domain.dart';
import 'package:speedy_go/domain/models/user_manager.dart';
import 'package:speedy_go/domain/usecase/history_trips_usecase.dart';
import 'package:speedy_go/presentation/base/base_cubit.dart';
import 'package:speedy_go/presentation/base/base_states.dart';

import '../../../../../../../../app/sl.dart';

class RequestHistoryViewModel extends BaseCubit
    implements RequestHistoryViewModelInput, RequestHistoryViewModelOutput {
  static RequestHistoryViewModel get(context) => BlocProvider.of(context);

  final HistoryTripsUseCase _historyTripsUseCase;
  final UserManager _userManager = sl<UserManager>();

  RequestHistoryViewModel(this._historyTripsUseCase);

  late final List<Future<HistoryTripModel>> _historyTrips;

  Future<String> findNearestPopularPlace(LatLng latLng) async {
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
            return placemark.name ?? 'Unknown Location';
          }
        }
      }
      return 'Unknown Location';
    } catch (e) {
      return 'Unknown Location';
    }
  }

  Future<void> _getHistoryTrips() async {
    emit(LoadingState());
    await _historyTripsUseCase(
      HistoryTripsUseCaseInput(
        id: _userManager.getCurrentPassenger!.uuid,
      ),
    ).then(
      (value) {
        value.fold(
          (l) {
            emit(ErrorState(failure: l));
          },
          (r) {
            _historyTrips = r.map(
              (trip) async {
                trip.setPickupAddress = await findNearestPopularPlace(
                  trip.pickupLocation,
                );
                trip.setDestinationAddress = await findNearestPopularPlace(
                  trip.destinationLocation,
                );
                return trip;
              },
            ).toList();
            emit(ContentState());
          },
        );
      },
    );
  }

  @override
  void start() {
    _getHistoryTrips();
  }

  @override
  List<Future<HistoryTripModel>> get getHistoryTrips => _historyTrips;
}

abstract class RequestHistoryViewModelInput {}

abstract class RequestHistoryViewModelOutput {
  List<Future<HistoryTripModel>> get getHistoryTrips;
}
