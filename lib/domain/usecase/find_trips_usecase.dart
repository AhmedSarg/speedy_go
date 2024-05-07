import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speedy_go/domain/models/enums.dart';

import '../../data/network/failure.dart';
import '../models/domain.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class FindTripsUseCase extends BaseUseCase<FindTripsUseCaseInput,
    Stream<List<(String, Future<TripPassengerModel>)>>> {
  final Repository _repository;

  FindTripsUseCase(this._repository);

  @override
  Future<Either<Failure, Stream<List<(String, Future<TripPassengerModel>)>>>>
      call(FindTripsUseCaseInput input) async {
    return _repository.findTrips(
      driverLocation: input.driverLocation,
      tripType: input.tripType,
    );
  }
}

class FindTripsUseCaseInput {
  final LatLng driverLocation;
  final TripType tripType;

  FindTripsUseCaseInput({
    required this.driverLocation,
    required this.tripType,
  });
}
