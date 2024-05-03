import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/network/failure.dart';
import '../models/domain.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class FindTripsUseCase extends BaseUseCase<FindTripsUseCaseInput, Stream<List<Future<TripPassengerModel>>>> {
  final Repository _repository;

  FindTripsUseCase(this._repository);

  @override
  Future<Either<Failure, Stream<List<Future<TripPassengerModel>>>>> call(FindTripsUseCaseInput input) async {
    return _repository.findTrips(input.driverLocation);
  }
}

class FindTripsUseCaseInput {
  final LatLng driverLocation;

  FindTripsUseCaseInput(this.driverLocation);
}
