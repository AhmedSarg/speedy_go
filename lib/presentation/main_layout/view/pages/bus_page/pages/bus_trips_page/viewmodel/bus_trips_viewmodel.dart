import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_go/presentation/base/base_cubit.dart';
import 'package:speedy_go/presentation/common/data_intent/data_intent.dart';

import '../../../../../../../../domain/models/domain.dart';

class BusTripsViewModel extends BaseCubit
    implements BusTripsViewModelInput, BusTripsViewModelOutput {
  static BusTripsViewModel get(context) => BlocProvider.of(context);

  late final Stream<List<TripBusModel>> _tripsStream;
  late final String _pickup;
  late final String _destination;
  late final DateTime _dateTime;

  @override
  void start() {
    _fetchData();
  }

  _fetchData() {
    _tripsStream = DataIntent.popTripsStream();
    _pickup = DataIntent.getBusPickup();
    _destination = DataIntent.getBusDestination();
    _dateTime = DataIntent.getBusDepartureDate();
  }

  @override
  Stream<List<TripBusModel>> get tripsStream => _tripsStream;

  @override
  String get getPickup => _pickup;

  @override
  String get getDestination => _destination;

  @override
  DateTime get getDepartureDate => _dateTime;
}

abstract class BusTripsViewModelInput {}

abstract class BusTripsViewModelOutput {
  Stream<List<TripBusModel>> get tripsStream;

  String get getPickup;

  String get getDestination;

  DateTime get getDepartureDate;
}
