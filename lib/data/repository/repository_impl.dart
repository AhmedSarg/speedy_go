import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:uuid/uuid.dart';

import '../../domain/models/enums.dart';
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

  // @override
  // Future<Either<Failure, Stream<FirebaseAuthException?>>> authenticate({
  //   required String email,
  //   required String password,
  //   required String phoneNumber,
  //   required RegisterType registerType,
  //   required Stream<String?> otpStream,
  // }) async {
  //   try {
  //     if (await _networkInfo.isConnected) {
  //       RegisteredBeforeError? error = await _remoteDataSource.doesUserExists(
  //         email: email,
  //         phoneNumber: phoneNumber,
  //         registerType: registerType,
  //       );
  //       if (error == null) {
  //         Stream<FirebaseAuthException?> errorStream =
  //             await _remoteDataSource.verifyPhoneNumber(
  //           email: email,
  //           password: password,
  //           phoneNumber: phoneNumber,
  //           otpStream: otpStream,
  //           authType: AuthType.register,
  //         );
  //         return Right(errorStream);
  //       } else {
  //         switch (error) {
  //           case RegisteredBeforeError.emailUsed:
  //             return Left(DataSource.EMAIL_ALREADY_EXISTS.getFailure());
  //           case RegisteredBeforeError.phoneNumberUsed:
  //             return Left(DataSource.PHONE_NUMBER_ALREADY_EXISTS.getFailure());
  //           case RegisteredBeforeError.emailAndPhoneNumberUsed:
  //             return Left(DataSource.EMAIL_AND_PHONE_NUMBER_ALREADY_EXISTS
  //                 .getFailure());
  //         }
  //       }
  //     } else {
  //       return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  //     }
  //   } catch (e) {
  //     return Left(ErrorHandler.handle(e).failure);
  //   }
  // }

  @override
  Future<Either<Failure, void>> doesUserExists({
    required String email,
    required String phoneNumber,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        RegisteredBeforeError? error = await _remoteDataSource.doesUserExists(
          email: email,
          phoneNumber: phoneNumber,
        );
        if (error == null) {
          return const Right(null);
        } else {
          switch (error) {
            case RegisteredBeforeError.emailUsed:
              return Left(DataSource.EMAIL_ALREADY_EXISTS.getFailure());
            case RegisteredBeforeError.phoneNumberUsed:
              return Left(DataSource.PHONE_NUMBER_ALREADY_EXISTS.getFailure());
            case RegisteredBeforeError.emailAndPhoneNumberUsed:
              return Left(DataSource.EMAIL_AND_PHONE_NUMBER_ALREADY_EXISTS
                  .getFailure());
          }
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Stream<FirebaseAuthException?>>> startVerify({
    String? email,
    String? password,
    required String phoneNumber,
    required StreamController<String?> otpStreamController,
    required AuthType authType,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        Stream<FirebaseAuthException?> errorStream =
            await _remoteDataSource.verifyPhoneNumber(
          email: authType == AuthType.register ? email : null,
          password: authType == AuthType.register ? password : null,
          phoneNumber: phoneNumber,
          otpStream: otpStreamController.stream,
          authType: authType,
        );
        return Right(errorStream);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> verifyOtp({
    required Stream<FirebaseAuthException?> errorStream,
    required StreamController<String?> otpStreamController,
    required String otp,
  }) async {
    late StreamSubscription streamSubscription;
    try {
      if (await _networkInfo.isConnected) {
        Completer<FirebaseAuthException?> retCompleter =
            Completer<FirebaseAuthException?>();
        streamSubscription = errorStream.listen((error) async {
          retCompleter.complete(error);
        });
        if (otp.isEmpty) {
          otpStreamController.add(null);
        } else {
          otpStreamController.add(otp);
        }
        FirebaseAuthException? result = await retCompleter.future;
        if (result == null) {
          return const Right(null);
        } else {
          throw result;
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } on FirebaseAuthException catch (e) {
      streamSubscription.cancel();
      if (e.code == 'invalid-verification-code') {
        return Left(DataSource.INVALID_VERIFICATION_CODE.getFailure());
      } else {
        return Left(ErrorHandler.handle(e).failure);
      }
    } catch (e) {
      streamSubscription.cancel();
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  // @override
  // Future<Either<Failure, void>> verify({
  //   required Stream<FirebaseAuthException?> errorStream,
  //   required StreamController<String?> otpStreamController,
  //   required String otp,
  // }) async {
  //   late StreamSubscription streamSubscription;
  //   try {
  //     if (await _networkInfo.isConnected) {
  //       Completer<FirebaseAuthException?> retCompleter =
  //           Completer<FirebaseAuthException?>();
  //       streamSubscription = errorStream.listen((error) async {
  //         retCompleter.complete(error);
  //       });
  //       if (otp.isEmpty) {
  //         otpStreamController.add(null);
  //       } else {
  //         otpStreamController.add(otp);
  //       }
  //       FirebaseAuthException? result = await retCompleter.future;
  //       if (result == null) {
  //         void ret;
  //         return Right(ret);
  //       } else {
  //         throw result;
  //       }
  //     } else {
  //       return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     streamSubscription.cancel();
  //     if (e.code == 'invalid-verification-code') {
  //       return Left(DataSource.INVALID_VERIFICATION_CODE.getFailure());
  //     } else {
  //       return Left(ErrorHandler.handle(e).failure);
  //     }
  //   } catch (e) {
  //     streamSubscription.cancel();
  //     return Left(ErrorHandler.handle(e).failure);
  //   }
  // }

  @override
  Future<Either<Failure, void>> register({
    required String firstName,
    required String lastName,
    required Gender? gender,
    required String phoneNumber,
    required String email,
    required String? nationalId,
    required File? drivingLicense,
    required File? carLicense,
    required File? carImage,
    required File? tukTukImage,
    required String password,
    required RegisterType registerType,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        String uuid = _uuidGenerator.v1();
        if (registerType == RegisterType.car) {
          await _remoteDataSource.registerCarDriverToDataBase(
            uuid: uuid,
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
            email: email,
            nationalId: nationalId!,
            drivingLicense: drivingLicense!,
            carLicense: carLicense!,
            carImage: carImage!,
            createdAt: DateTime.now(),
          );
        } else if (registerType == RegisterType.tuktuk) {
          await _remoteDataSource.registerTukTukDriverToDataBase(
            uuid: uuid,
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
            email: email,
            nationalId: nationalId!,
            tukTukImage: tukTukImage!,
            createdAt: DateTime.now(),
          );
        } else {
          await _remoteDataSource.registerPassengerToDataBase(
            uuid: uuid,
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
            email: email,
            gender: gender! == Gender.female ? 'female' : 'male',
            createdAt: DateTime.now(),
          );
        }
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
  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.loginWithEmailPassword(
          email: email,
          password: password,
        );
        return const Right(null);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        return Left(DataSource.EMAIL_LOGIN_FAILED.getFailure());
      } else {
        return Left(ErrorHandler.handle(e).failure);
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
