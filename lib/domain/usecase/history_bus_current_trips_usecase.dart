import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class HistoryBusCurrentTripsUseCase
    extends BaseUseCase<HistoryBusCurrentTripsUseCaseInput, void> {
  final Repository _repository;

  HistoryBusCurrentTripsUseCase(this._repository);

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> call(
      HistoryBusCurrentTripsUseCaseInput input) async {
    return _repository.historyOfBusCurrentTrips(
      id: input.id,
    );
  }
}

class HistoryBusCurrentTripsUseCaseInput {
  final String id;

  HistoryBusCurrentTripsUseCaseInput({
    required this.id,
  });
}
