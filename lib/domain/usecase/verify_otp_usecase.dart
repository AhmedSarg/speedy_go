import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/network/failure.dart';
import '../models/enums.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class VerifyOtpUseCase extends BaseUseCase<VerifyOtpUseCaseInput, void> {
  final Repository _repository;

  VerifyOtpUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(VerifyOtpUseCaseInput input) async {
    return _repository.verifyOtp(
      otpStreamController: input.otpStreamController,
      errorStream: input.errorStream,
      otp: input.otp,
      phoneNumber: input.phoneNumber,
      authType: input.authType,
    );
  }
}

class VerifyOtpUseCaseInput {
  StreamController<String?> otpStreamController;
  Stream<FirebaseAuthException?> errorStream;
  String otp;
  String phoneNumber;
  AuthType authType;

  VerifyOtpUseCaseInput({
    required this.otpStreamController,
    required this.errorStream,
    required this.otp,
    required this.phoneNumber,
    required this.authType,
  });
}
