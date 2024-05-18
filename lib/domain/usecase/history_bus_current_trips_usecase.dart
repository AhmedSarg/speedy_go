import 'package:dartz/dartz.dart';
import 'package:speedy_go/domain/models/domain.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class HistoryBusCurrentTripsUseCase extends BaseUseCase<
    HistoryBusCurrentTripsUseCaseInput, List<TripBusModel>> {
  final Repository _repository;

  HistoryBusCurrentTripsUseCase(this._repository);

  @override
  Future<Either<Failure, List<TripBusModel>>> call(
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
