import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class CancelTripUseCase extends BaseUseCase<CancelTripUseCaseInput, void> {
  final Repository _repository;

  CancelTripUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(CancelTripUseCaseInput input) async {
    return _repository.cancelTrip(input.tripId);
  }
}

class CancelTripUseCaseInput {
  final String tripId;

  CancelTripUseCaseInput({
    required this.tripId,
  });
}
