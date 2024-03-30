import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class AuthenticateUseCase extends BaseUseCase<AuthenticateUseCaseInput, void> {
  final Repository _repository;

  AuthenticateUseCase(this._repository);

  @override
  Future<Either<Failure, User>> call(AuthenticateUseCaseInput input) async {
    return _repository.authenticateUser(
      email: input.email,
      password: input.password,
    );
  }
}

class AuthenticateUseCaseInput {
  final String email;
  final String password;

  AuthenticateUseCaseInput({
    required this.email,
    required this.password,
  });
}