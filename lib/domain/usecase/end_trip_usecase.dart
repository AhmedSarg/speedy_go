import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class EndTripUseCase extends BaseUseCase<EndTripUseCaseInput, void> {
  final Repository _repository;

  EndTripUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(EndTripUseCaseInput input) async {
    return _repository.endTrip(input.tripId);
  }
}

class EndTripUseCaseInput {
  final String tripId;

  EndTripUseCaseInput({
    required this.tripId,
  });
}
