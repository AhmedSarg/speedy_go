import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class CurrentUserUseCase extends BaseUseCase<void, void> {
  final Repository _repository;

  CurrentUserUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(void input) async {
    return _repository.getCurrentUser();
  }
}
