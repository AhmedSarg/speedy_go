import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class BookBusTripUseCase extends BaseUseCase<BookBusTripUseCaseInput, void> {
  final Repository _repository;

  BookBusTripUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(BookBusTripUseCaseInput input) async {
    return _repository.bookBusTicket(
      busTripId: input.busTripId,
      userId: input.userId,
      seats: input.seats,
    );
  }
}

class BookBusTripUseCaseInput {
  final String busTripId;
  final String userId;
  final int seats;

  BookBusTripUseCaseInput({
    required this.busTripId,
    required this.userId,
    required this.seats,
  });
}
