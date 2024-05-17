import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class HistoryBusPastTripsUseCase
    extends BaseUseCase<HistoryBusPastTripsUseCaseInput, void> {
  final Repository _repository;

  HistoryBusPastTripsUseCase(this._repository);

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> call(
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
