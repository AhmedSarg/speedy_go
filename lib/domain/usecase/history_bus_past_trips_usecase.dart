import 'package:dartz/dartz.dart';
import 'package:speedy_go/domain/models/domain.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class HistoryBusPastTripsUseCase
    extends BaseUseCase<HistoryBusPastTripsUseCaseInput, List<TripBusModel>> {
  final Repository _repository;

  HistoryBusPastTripsUseCase(this._repository);

  @override
  Future<Either<Failure, List<TripBusModel>>> call(
      HistoryBusPastTripsUseCaseInput input) async {
    return _repository.historyOfBusPastTrips(
      id: input.id,
      // date: input.date,
    );
  }
}

class HistoryBusPastTripsUseCaseInput {
  final String id;
  // final DateTime date;

  HistoryBusPastTripsUseCaseInput({
    required this.id,
    // required this.date,
  });
}
