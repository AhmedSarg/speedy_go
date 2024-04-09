import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class LoginUseCase extends BaseUseCase<LoginUseCaseInput, void> {
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(LoginUseCaseInput input) async {
    return _repository.login(
      email: input.email,
      password: input.password,
    );
  }
}

class LoginUseCaseInput {
  final String email;
  final String password;

  LoginUseCaseInput({
    required this.email,
    required this.password,
  });
}