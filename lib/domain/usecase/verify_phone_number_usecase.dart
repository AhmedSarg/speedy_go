import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class VerifyPhoneNumberUseCase extends BaseUseCase<VerifyPhoneNumberUseCaseInput, void> {
  final Repository _repository;

  VerifyPhoneNumberUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(VerifyPhoneNumberUseCaseInput input) async {
    return _repository.verifyPhoneNumber(
      phoneNumber: input.phoneNumber,
      user: input.user,
      otp: input.otp,
    );
  }
}

class VerifyPhoneNumberUseCaseInput {
  final String phoneNumber;
  final User user;
  final String otp;

  VerifyPhoneNumberUseCaseInput({
    required this.phoneNumber,
    required this.user,
    required this.otp,
  });
}