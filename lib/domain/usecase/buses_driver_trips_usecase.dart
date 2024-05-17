import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../models/domain.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class BusesDriverTripsUseCase
    extends BaseUseCase<BusesDriverTripsUseCaseInput, Stream<List<Future<TripBusModel>>>> {
  final Repository _repository;

  BusesDriverTripsUseCase(this._repository);

  @override
  Future<Either<Failure, Stream<List<Future<TripBusModel>>>>> call(
      BusesDriverTripsUseCaseInput input) async {
    return _repository.busesDriverTrips(
      driverId: input.driverId,
      date: input.date,
    );
  }
}

class BusesDriverTripsUseCaseInput {
  final String driverId;
  final DateTime date;

  BusesDriverTripsUseCaseInput({
    required this.driverId,
    required this.date,
  });
}
