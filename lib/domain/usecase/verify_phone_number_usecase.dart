import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/network/failure.dart';
import '../models/enums.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class VerifyPhoneNumberUseCase extends BaseUseCase<VerifyPhoneNumberUseCaseInput, void> {
  final Repository _repository;

  VerifyPhoneNumberUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(VerifyPhoneNumberUseCaseInput input) async {
    return _repository.verify(
      errorStream: input.errorStream,
      otpStreamController: input.otpStreamController,
      otp: input.otp,
      registerType: input.registerType,
    );
  }
}

class VerifyPhoneNumberUseCaseInput {
  Stream<FirebaseAuthException?> errorStream;
  StreamController<String?> otpStreamController;
  String otp;
  RegisterType registerType;

  VerifyPhoneNumberUseCaseInput({
    required this.errorStream,
    required this.otpStreamController,
    required this.otp,
    required this.registerType,
  });
}