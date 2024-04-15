import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class CalculateTwoPointsUseCase
    extends BaseUseCase<CalculateTwoPointsUseCaseInput, void> {
  final Repository _repository;

  CalculateTwoPointsUseCase(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
      CalculateTwoPointsUseCaseInput input) async {
    return _repository.calculateTwoPoints(
      pointA: input.pointA,
      pointB: input.pointB,
    );
  }
}

class CalculateTwoPointsUseCaseInput {
  final LatLng pointA;
  final LatLng pointB;

  CalculateTwoPointsUseCaseInput({
    required this.pointA,
    required this.pointB,
  });
}
