import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class RateUseCase extends BaseUseCase<RateUseCaseInput, void> {
  final Repository _repository;

  RateUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(RateUseCaseInput input) async {
    return _repository.rate(
      input.userId,
      input.rate,
    );
  }
}

class RateUseCaseInput {
  final String userId;
  final int rate;

  RateUseCaseInput({
    required this.userId,
    required this.rate,
  });
}
