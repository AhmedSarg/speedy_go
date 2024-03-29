import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';

abstract class Repository {
  // Future<Either<Failure, NewsListModel>> getNewsList();

  Future<Either<Failure, void>> registerCarDriver({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String nationalId,
    required File drivingLicense,
    required File carLicense,
    required File carImage,
    required String password,
  });
}
