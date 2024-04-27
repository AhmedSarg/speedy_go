import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class ChangeDriverStatusUseCase extends BaseUseCase<ChangeDriverStatusUseCaseInput, void> {
  final Repository _repository;

  ChangeDriverStatusUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(ChangeDriverStatusUseCaseInput input) async {
    return _repository.changeDriverStatus(
      online: input.online,
      driverId: input.driverId,
      coordinatesSubscription: input.coordinatesSubscription,
    );
  }
}

class ChangeDriverStatusUseCaseInput {
  final bool online;
  final String driverId;
  final StreamSubscription<LatLng>? coordinatesSubscription;

  ChangeDriverStatusUseCaseInput({
    required this.online,
    required this.driverId,
    this.coordinatesSubscription,
  });
}
