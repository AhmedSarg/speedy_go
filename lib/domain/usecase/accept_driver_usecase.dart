import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class AcceptDriverUseCase
    extends BaseUseCase<AcceptDriverUseCaseInput, Future<void>> {
  final Repository _repository;

  AcceptDriverUseCase(this._repository);

  @override
  Future<Either<Failure, Future<void>>> call(AcceptDriverUseCaseInput input) async {
    return _repository.acceptDriver(
      tripId: input.tripId,
      driverId: input.driverId,
      price: input.price,
    );
  }
}

class AcceptDriverUseCaseInput {
  final String tripId;
  final String driverId;
  final int price;

  AcceptDriverUseCaseInput({
    required this.tripId,
    required this.driverId,
    required this.price,
  });
}
