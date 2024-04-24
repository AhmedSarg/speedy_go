import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class GetSignedUserUseCase extends BaseUseCase<void, User?> {
  final Repository _repository;

  GetSignedUserUseCase(this._repository);

  @override
  Future<Either<Failure, User?>> call(void input) async {
    return _repository.getSignedUser();
  }
}