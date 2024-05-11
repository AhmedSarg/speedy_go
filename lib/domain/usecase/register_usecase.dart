import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../models/enums.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class RegisterUseCase extends BaseUseCase<RegisterUseCaseInput, void> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(RegisterUseCaseInput input) async {
    return _repository.register(
      firstName: input.firstName,
      lastName: input.lastName,
      gender: input.gender,
      phoneNumber: input.phoneNumber,
      email: input.email,
      nationalId: input.nationalId,
      drivingLicense: input.drivingLicense,
      carLicense: input.carLicense,
      tukTukImage: input.tukTukImage,
      carImage: input.carImage,
      vehicleModel: input.vehicleModel,
      vehicleColor: input.vehicleColor,
      vehiclePlate: input.vehiclePlate,
      registerType: input.registerType
    );
  }
}

class RegisterUseCaseInput {
  final String firstName;
  final String lastName;
  final Gender? gender;
  final String phoneNumber;
  final String email;
  final String? nationalId;
  final File? drivingLicense;
  final File? carLicense;
  final File? carImage;
  final File? tukTukImage;
  final String? vehicleModel;
  final String? vehicleColor;
  final String? vehiclePlate;
  final RegisterType registerType;

  RegisterUseCaseInput({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.phoneNumber,
    required this.email,
    required this.nationalId,
    required this.drivingLicense,
    required this.carLicense,
    required this.carImage,
    required this.tukTukImage,
    required this.vehicleModel,
    required this.vehicleColor,
    required this.vehiclePlate,
    required this.registerType,
  });
}