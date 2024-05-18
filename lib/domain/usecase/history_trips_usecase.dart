import 'package:dartz/dartz.dart';
import 'package:speedy_go/domain/models/domain.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class HistoryTripsUseCase
    extends BaseUseCase<HistoryTripsUseCaseInput, List<HistoryTripModel>> {
  final Repository _repository;

  HistoryTripsUseCase(this._repository);

  @override
  Future<Either<Failure, List<HistoryTripModel>>> call(
      HistoryTripsUseCaseInput input) async {
    return _repository.historyOfTrips(
      id: input.id,
    );
  }
}

class HistoryTripsUseCaseInput {
  final String id;

  HistoryTripsUseCaseInput({
    required this.id,
  });
}
