import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/base/base_cubit.dart';
import 'package:speedy_go/presentation/base/base_states.dart';
import 'package:speedy_go/presentation/common/data_intent/data_intent.dart';
import 'package:speedy_go/presentation/main_layout/view/pages/bus_page/pages/bus_trips_page/states/bus_trips_states.dart';

import '../../../../../../../../domain/models/domain.dart';

class BusTripsViewModel extends BaseCubit
    implements BusTripsViewModelInput, BusTripsViewModelOutput {
  static BusTripsViewModel get(context) => BlocProvider.of(context);

  late final Stream<List<TripBusModel>> _tripsStream;
  late final String _pickup;
  late final String _destination;
  late final DateTime _dateTime;
  int _bookedSeats = 1;

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
    emit(TripTappedState(trip));
  }

  addSeat() {
    _bookedSeats += 1;
  }

  removeSeat() {
    _bookedSeats -= 1;
  }

  @override
  Stream<List<TripBusModel>> get getTripsStream => _tripsStream;

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
  Stream<List<TripBusModel>> get getTripsStream;

  String get getPickup;

  String get getDestination;

  DateTime get getDepartureDate;

  int get getBookedSeats;
}
