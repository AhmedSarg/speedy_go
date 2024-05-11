import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/network/failure.dart';
import '../models/domain.dart';
import '../models/enums.dart';

abstract class Repository {
  Future<Either<Failure, void>> addBus({
    required String driverId,
    required String busId,
    required String firstName,
    required String lastName,
    required File busLicense,
    required File drivingLicense,
    required String nationalID,
    required String phoneNumber,
    required File busImage,
    required int seatsNumber,
  });

  Future<Either<Failure, void>> addBusTrip({
    required String driverId,
    required int numberOfBus,
    required double price,
    required String pickupLocation,
    required String destinationLocation,
    required DateTime calendar,
  });

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
    required String phoneNumber,
    required AuthType authType,
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

  Future<Either<Failure, (Stream<List<Future<TripDriverModel>>>, String)>>
      findDrivers({
    required String passengerId,
    required TripType tripType,
    required LatLng pickupLocation,
    required LatLng destinationLocation,
    required int price,
    required int expectedTime,
    required int distance,
  });

  Future<Either<Failure, Map<String, dynamic>>> calculateTwoPoints({
    required LatLng pointA,
    required LatLng pointB,
  });

  Future<Either<Failure, void>> cancelTrip(String tripId);

  Either<Failure, void> getCurrentUser();

  Future<Either<Failure, Future<void>>> acceptDriver({
    required String tripId,
    required String driverId,
    required int price,
  });

  Future<Either<Failure, void>> endTrip(String tripId);

  Future<Either<Failure, User?>> getSignedUser();

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, void>> rate(String userId, int rate);

  Future<Either<Failure, void>> changeDriverStatus({
    required bool online,
    required String driverId,
    StreamSubscription<LatLng>? coordinatesSubscription,
  });

  Future<Either<Failure, Stream<List<(String, Future<TripPassengerModel>)>>>>
      findTrips({
    required LatLng driverLocation,
    required TripType tripType,
  });

  Future<Either<Failure, Future<bool>>> acceptTrip({
    required String driverId,
    required String tripId,
    required int price,
    required String location,
    required LatLng coordinates,
  });

  Future<Either<Failure, void>> cancelAcceptTrip(
      String driverId, String tripId);

  Future<Either<Failure, Stream<List<Future<TripBusModel>>>>> findBusTrips({
    required String pickup,
    required String destination,
    required DateTime date,
  });
}
