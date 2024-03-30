import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:uuid/uuid.dart';

import '../../domain/repository/repository.dart';
import '../data_source/remote_data_source.dart';
import '../network/error_handler.dart';
import '../network/failure.dart';
import '../network/network_info.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;

  // final LocalDataSource _localDataSource;
  // final CacheDataSource _cacheDataSource;
  final NetworkInfo _networkInfo;

  // final GSheetFactory _gSheetFactory;
  // final DateNTP _dateNTP;
  final Uuid _uuidGenerator = const Uuid();

  RepositoryImpl(
    this._remoteDataSource,
    // this._localDataSource,
    this._networkInfo,
    // this._cacheDataSource,
    // this._gSheetFactory,
    // this._dateNTP,
  );

  @override
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
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        String uuid = _uuidGenerator.v1();
        await _remoteDataSource.registerCarDriverToDataBase(
          uuid: uuid,
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          email: email,
          nationalId: nationalId,
          drivingLicense: drivingLicense,
          carLicense: carLicense,
          carImage: carImage,
          createdAt: DateTime.now(),
        );
        void ret;
        return Right(ret);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, User>> authenticateUser({
    required String email,
    required String password,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        UserCredential userCredential =
            await _remoteDataSource.registerEmailPasswordToAuth(
          email: email,
          password: password,
        );
        return Right(userCredential.user!);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return Left(DataSource.EMAIL_ALREADY_EXISTS.getFailure());
      } else {
        return Left(ErrorHandler.handle(e).failure);
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> verifyPhoneNumber({
    required String phoneNumber,
    required User user,
    required String otp,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        FirebaseAuthException? value = await _remoteDataSource.verifyPhoneNumberForRegister(
          phoneNumber: phoneNumber,
          user: user,
          otp: otp,
        );
        if (value != null) {
          throw value;
        }
        else {
          return const Right(true);
        }
      } else {
        user.delete();
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        return Left(DataSource.INVALID_VERIFICATION_CODE.getFailure());
      } else {
        user.delete();
        return Left(ErrorHandler.handle(e).failure);
      }
    } catch (e) {
      user.delete();
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
