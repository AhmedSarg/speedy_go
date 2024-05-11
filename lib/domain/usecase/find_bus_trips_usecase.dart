import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../models/domain.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class FindBusTripsUseCase extends BaseUseCase<FindBusTripsUseCaseInput,
    Stream<List<Future<TripBusModel>>>> {
  final Repository _repository;

  FindBusTripsUseCase(this._repository);

  @override
  Future<Either<Failure, Stream<List<Future<TripBusModel>>>>> call(
      FindBusTripsUseCaseInput input) async {
    return _repository.findBusTrips(
      pickup: input.pickup,
      destination: input.destination,
      date: input.date,
    );
  }
}

class FindBusTripsUseCaseInput {
  final String pickup;
  final String destination;
  final DateTime date;

  FindBusTripsUseCaseInput({
    required this.pickup,
    required this.destination,
    required this.date,
  });
}
