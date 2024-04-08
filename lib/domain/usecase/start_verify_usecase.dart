import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/network/failure.dart';
import '../models/enums.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class StartVerifyUseCase extends BaseUseCase<StartVerifyUseCaseInput, void> {
  final Repository _repository;

  StartVerifyUseCase(this._repository);

  @override
  Future<Either<Failure, Stream<FirebaseAuthException?>>> call(StartVerifyUseCaseInput input) async {
    return _repository.startVerify(
      phoneNumber: input.phoneNumber,
      email: input.email,
      password: input.password,
      otpStreamController: input.otpStreamController,
      authType: input.authType,
    );
  }
}

class StartVerifyUseCaseInput {
  String phoneNumber;
  String? email;
  String? password;
  StreamController<String?> otpStreamController;
  AuthType authType;

  StartVerifyUseCaseInput({
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.otpStreamController,
    required this.authType,
  });
}
