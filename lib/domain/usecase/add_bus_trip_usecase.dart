import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class AddBusTripUseCase extends BaseUseCase<AddBusTripUseCaseInput, void> {
  final Repository _repository;

  AddBusTripUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(AddBusTripUseCaseInput input) async {
    return _repository.addBusTrip(
      driverId: input.driverId,
      busId: input.busId,
      price: input.price,
      pickupLocation: input.pickupLocation,
      destinationLocation: input.destinationLocation,
      calendar: input.calendar,
    );
  }
}

class AddBusTripUseCaseInput {
  final String driverId;
  final double price;
  final String busId;
  final String pickupLocation;
  final String destinationLocation;
  final DateTime calendar;

  AddBusTripUseCaseInput({
    required this.driverId,
    required this.busId,
    required this.price,
    required this.pickupLocation,
    required this.destinationLocation,
    required this.calendar,
  });
}
