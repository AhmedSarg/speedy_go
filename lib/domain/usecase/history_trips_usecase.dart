import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class HistoryTripsUseCase extends BaseUseCase<HistoryTripsUseCaseInput, void> {
  final Repository _repository;

  HistoryTripsUseCase(this._repository);

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> call(
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
