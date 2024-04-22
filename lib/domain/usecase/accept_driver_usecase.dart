import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class AcceptDriverUseCase
    extends BaseUseCase<AcceptDriverUseCaseInput, void> {
  final Repository _repository;

  AcceptDriverUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(AcceptDriverUseCaseInput input) async {
    return _repository.acceptDriver(
      tripId: input.tripId,
      driverId: input.driverId,
    );
  }
}

class AcceptDriverUseCaseInput {
  final String tripId;
  final String driverId;

  AcceptDriverUseCaseInput({
    required this.tripId,
    required this.driverId,
  });
}
