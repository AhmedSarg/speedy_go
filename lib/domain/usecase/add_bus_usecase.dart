
import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class AddBusUseCase extends BaseUseCase<AddBusUseCaseInput, void> {
  final Repository _repository;

  AddBusUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(AddBusUseCaseInput input) async {
    return _repository.addBus(
      driverId: input.driverId,
      busId: input.busId,
      firstName: input.firstName,
      lastName: input.lastName,
      busLicense: input.busLicense,
      drivingLicense: input.drivingLicense,
      nationalID: input.nationalID,
      phoneNumber: input.phoneNumber,
      busImage: input.busImage,
      seatsNumber: input.seatsNumber,
    );
  }
}

class AddBusUseCaseInput {
  final String driverId;
  final String busId;
  final String firstName;
  final String lastName;
  final File busLicense;
  final File drivingLicense;
  final String nationalID;
  final String phoneNumber;
  final File busImage;
  final int seatsNumber;

  AddBusUseCaseInput(
      this.driverId,
      this.busId,
      this.firstName,
      this.lastName,
      this.busLicense,
      this.drivingLicense,
      this.nationalID,
      this.phoneNumber,
      this.busImage,
      this.seatsNumber);
}
