import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/domain/models/user_manager.dart';
import 'package:speedy_go/domain/usecase/book_bus_trip_usecase.dart';
import 'package:speedy_go/presentation/base/base_cubit.dart';
import 'package:speedy_go/presentation/base/base_states.dart';
import 'package:speedy_go/presentation/common/data_intent/data_intent.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/bus_page/pages/bus_trips_page/states/bus_trips_states.dart';

import '../../../../../../../../app/sl.dart';
import '../../../../../../../../domain/models/domain.dart';

class BusTripsViewModel extends BaseCubit
    implements BusTripsViewModelInput, BusTripsViewModelOutput {
  static BusTripsViewModel get(context) => BlocProvider.of(context);

  final BookBusTripUseCase _bookBusTripUseCase;
  final UserManager _userManager = sl<UserManager>();

  BusTripsViewModel(this._bookBusTripUseCase);

  late final Stream<List<Future<TripBusModel>>> _tripsStream;
  late final String _pickup;
  late final String _destination;
  late final DateTime _dateTime;
  int _bookedSeats = 1;
  TripBusModel? _lastClickedTrip;

  @override
  void start() {
    _fetchData();
  }

  _fetchData() {
    emit(LoadingState());
    _tripsStream = DataIntent.popTripsStream();
    _pickup = DataIntent.getBusPickup();
    _destination = DataIntent.getBusDestination();
    _dateTime = DataIntent.getBusDepartureDate();
    emit(ContentState());
  }

  onTapTrip(TripBusModel trip) {
    if (trip.id != _lastClickedTrip?.id) {
      _bookedSeats = 1;
    }
    _lastClickedTrip = trip;
    emit(TripTappedState(trip, false));
  }

  addSeat() {
    _bookedSeats += 1;
    emit(TripTappedState(_lastClickedTrip!, true));
  }

  removeSeat() {
    _bookedSeats -= 1;
    emit(TripTappedState(_lastClickedTrip!, true));
  }

  Future<void> bookBusTrip() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    await _bookBusTripUseCase(
      BookBusTripUseCaseInput(
        busTripId: _lastClickedTrip!.id,
        userId: _userManager.getCurrentPassenger!.uuid,
        seats: _bookedSeats,
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
          (r) {
            emit(SuccessState(message: 'Tickets Booked Successfully'));
          },
        );
      },
    );
  }

  @override
  Stream<List<Future<TripBusModel>>> get getTripsStream => _tripsStream;

  @override
  String get getPickup => _pickup;

  @override
  String get getDestination => _destination;

  @override
  DateTime get getDepartureDate => _dateTime;

  @override
  int get getBookedSeats => _bookedSeats;
}

abstract class BusTripsViewModelInput {}

abstract class BusTripsViewModelOutput {
  Stream<List<Future<TripBusModel>>> get getTripsStream;

  String get getPickup;

  String get getDestination;

  DateTime get getDepartureDate;

  int get getBookedSeats;
}
