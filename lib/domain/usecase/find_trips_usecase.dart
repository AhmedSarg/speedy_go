import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../models/domain.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class FindTripsUseCase extends BaseUseCase<void, Stream<List<TripPassengerModel>>> {
  final Repository _repository;

  FindTripsUseCase(this._repository);

  @override
  Future<Either<Failure, Stream<List<TripPassengerModel>>>> call(void input) async {
    return _repository.findTrips();
  }
}

class FindTripsUseCaseInput {}
