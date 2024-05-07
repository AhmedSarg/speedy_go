import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    );
  }
}

class FindTripsUseCaseInput {
  final LatLng driverLocation;

  FindTripsUseCaseInput({
    required this.driverLocation,
  });
}
