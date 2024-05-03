import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class CancelAcceptTripUseCase extends BaseUseCase<CancelAcceptTripUseCaseInput, void> {
  final Repository _repository;

  CancelAcceptTripUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(CancelAcceptTripUseCaseInput input) async {
    return _repository.cancelAcceptTrip(input.driverId, input.tripId);
  }
}

class CancelAcceptTripUseCaseInput {
  final String tripId;
  final String driverId;

  CancelAcceptTripUseCaseInput({
    required this.tripId,
    required this.driverId,
  });
}
