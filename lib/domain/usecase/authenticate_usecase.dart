import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class AuthenticateUseCase extends BaseUseCase<AuthenticateUseCaseInput, void> {
  final Repository _repository;

  AuthenticateUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(AuthenticateUseCaseInput input) async {
    return _repository.doesUserExists(
      email: input.email,
      phoneNumber: input.phoneNumber,
    );
  }
}

class AuthenticateUseCaseInput {
  final String email;
  final String phoneNumber;

  AuthenticateUseCaseInput({
    required this.email,
    required this.phoneNumber,
  });
}