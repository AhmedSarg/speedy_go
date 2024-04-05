import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/network/failure.dart';
import '../models/enums.dart';

abstract class Repository {

  Future<Either<Failure, Stream<FirebaseAuthException?>>> authenticate({
    required String email,
    required String password,
    required String phoneNumber,
    required RegisterType registerType,
    required Stream<String?> otpStream,
  });

  Future<Either<Failure, void>> verify({
    required Stream<FirebaseAuthException?> errorStream,
    required StreamController<String?> otpStreamController,
    required String otp,
    required RegisterType registerType,
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

  Future<Either<Failure, Stream<FirebaseAuthException?>?>> login({
    required String email,
    required String password,
    required String phoneNumber,
    required LoginType loginType,
    required Stream<String?>? otpStream,
  });
}
