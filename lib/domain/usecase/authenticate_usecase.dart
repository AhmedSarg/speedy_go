import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:speedy_go/domain/models/enums.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class AuthenticateUseCase extends BaseUseCase<AuthenticateUseCaseInput, void> {
  final Repository _repository;

  AuthenticateUseCase(this._repository);

  @override
  Future<Either<Failure, Stream<FirebaseAuthException?>>> call(AuthenticateUseCaseInput input) async {
    return _repository.authenticate(
      email: input.email,
      password: input.password,
      phoneNumber: input.phoneNumber,
      registerType: input.registerType,
      otpStream: input.otpStream,
    );
  }
}

class AuthenticateUseCaseInput {
  final String email;
  final String password;
  final String phoneNumber;
  final RegisterType registerType;
  final Stream<String?> otpStream;

  AuthenticateUseCaseInput({
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.registerType,
    required this.otpStream,
  });
}