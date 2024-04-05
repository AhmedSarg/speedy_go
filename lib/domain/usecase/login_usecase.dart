import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/network/failure.dart';
import '../models/enums.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class LoginUseCase extends BaseUseCase<LoginUseCaseInput, void> {
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Stream<FirebaseAuthException?>?>> call(LoginUseCaseInput input) async {
    return _repository.login(
      email: input.email,
      password: input.password,
      phoneNumber: input.phoneNumber,
      loginType: input.loginType,
      otpStream: input.otpStream,
    );
  }
}

class LoginUseCaseInput {
  final String email;
  final String password;
  final String phoneNumber;
  final LoginType loginType;
  final Stream<String?>? otpStream;

  LoginUseCaseInput({
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.loginType,
    required this.otpStream,
  });
}