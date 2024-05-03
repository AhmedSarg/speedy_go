import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class AcceptTripUseCase
    extends BaseUseCase<AcceptTripUseCaseInput, Future<bool>> {
  final Repository _repository;

  AcceptTripUseCase(this._repository);

  @override
  Future<Either<Failure, Future<bool>>> call(
      AcceptTripUseCaseInput input) async {
    return _repository.acceptTrip(
      driverId: input.driverId,
      tripId: input.tripId,
      price: input.price,
      location: input.location,
      coordinates: input.coordinates,
    );
  }
}

class AcceptTripUseCaseInput {
  final String tripId;
  final String driverId;
  final int price;
  final String location;
  final LatLng coordinates;

  AcceptTripUseCaseInput({
    required this.tripId,
    required this.driverId,
    required this.price,
    required this.location,
    required this.coordinates,
  });
}
