import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../models/domain.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class DisplayBusesUseCase
    extends BaseUseCase<DisplayBusesUseCaseInput, Stream<List<BusModel>>> {
  final Repository _repository;

  DisplayBusesUseCase(this._repository);

  @override
  Future<Either<Failure, Stream<List<BusModel>>>> call(
      DisplayBusesUseCaseInput input) async {
    return _repository.displayBuses(
     driverId: input.driverId
    );
  }
}

class DisplayBusesUseCaseInput {
  final String driverId;

  DisplayBusesUseCaseInput( {
    required this.driverId,
  });
}
