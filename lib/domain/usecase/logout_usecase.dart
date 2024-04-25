import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class LogoutUseCase extends BaseUseCase<void, void> {
  final Repository _repository;

  LogoutUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(void input) async {
    return _repository.logout();
  }
}