import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/network/failure.dart';
import '../models/domain.dart';
import '../models/enums.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class FindDriversUseCase extends BaseUseCase<FindDriversUseCaseInput, void> {
  final Repository _repository;

  FindDriversUseCase(this._repository);

  @override
  Future<Either<Failure, (Stream<List<Future<TripDriverModel>>>, String)>> call(FindDriversUseCaseInput input) async {
    return _repository.findDrivers(
      passengerId: input.passengerId,
      tripType: input.tripType,
      pickupLocation: input.pickupLocation,
      destinationLocation: input.destinationLocation,
      price: input.price,
      expectedTime: input.expectedTime,
      distance: input.distance,
    );
  }
}

class FindDriversUseCaseInput {
  final String passengerId;
  final TripType tripType;
  final LatLng pickupLocation;
  final LatLng destinationLocation;
  final int price;
  final int expectedTime;
  final int distance;

  FindDriversUseCaseInput({
    required this.passengerId,
    required this.tripType,
    required this.pickupLocation,
    required this.destinationLocation,
    required this.price,
    required this.expectedTime,
    required this.distance,
  });
}
