import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class RegisterCarDriverUseCase extends BaseUseCase<RegisterCarDriverUseCaseInput, void> {
  final Repository _repository;

  RegisterCarDriverUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(RegisterCarDriverUseCaseInput input) async {
    return _repository.registerCarDriver(
      firstName: input.firstName,
      lastName: input.lastName,
      phoneNumber: input.phoneNumber,
      email: input.email,
      nationalId: input.nationalId,
      drivingLicense: input.drivingLicense,
      carLicense: input.carLicense,
      carImage: input.carImage,
      password: input.password,
    );
  }
}

class RegisterCarDriverUseCaseInput {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String nationalId;
  final File drivingLicense;
  final File carLicense;
  final File carImage;
  final String password;

  RegisterCarDriverUseCaseInput({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.nationalId,
    required this.drivingLicense,
    required this.carLicense,
    required this.carImage,
    required this.password,
  });
}