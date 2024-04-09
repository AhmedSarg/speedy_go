import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/network/failure.dart';
import '../models/enums.dart';

abstract class Repository {

  // Future<Either<Failure, Stream<FirebaseAuthException?>>> authenticate({
  //   required String email,
  //   required String password,
  //   required String phoneNumber,
  //   required RegisterType registerType,
  //   required Stream<String?> otpStream,
  // });

  Future<Either<Failure, void>> doesUserExists({
    required String email,
    required String phoneNumber,
  });

  Future<Either<Failure, Stream<FirebaseAuthException?>>> startVerify({
    String? email,
    String? password,
    required String phoneNumber,
    required StreamController<String?> otpStreamController,
    required AuthType authType,
  });

  Future<Either<Failure, void>> verifyOtp({
    required Stream<FirebaseAuthException?> errorStream,
    required StreamController<String?> otpStreamController,
    required String otp,
  });

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
  });

  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  });
}
