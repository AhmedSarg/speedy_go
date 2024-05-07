import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speedy_go/domain/models/user_manager.dart';
import 'package:speedy_go/presentation/resources/assets_manager.dart';

import 'package:uuid/uuid.dart';

import '../../domain/models/domain.dart';
import '../../domain/models/enums.dart';
import '../../domain/repository/repository.dart';
import '../data_source/cache_data_source.dart';
import '../data_source/remote_data_source.dart';
import '../network/error_handler.dart';
import '../network/failure.dart';
import '../network/network_info.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final CacheDataSource _cacheDataSource;
  final NetworkInfo _networkInfo;
  final UserManager _userManager;
  final Uuid _uuidGenerator = const Uuid();

  RepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
    this._cacheDataSource,
    this._userManager,
  );

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
    required String phoneNumber,
    required AuthType authType,
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
          if (authType == AuthType.login) {
            await _storeCurrentUser(phoneNumber: phoneNumber);
          }
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
        await _storeCurrentUser(phoneNumber: phoneNumber);
        return const Right(null);
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
        await _storeCurrentUser(email: email);
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

  @override
  Future<Either<Failure, (Stream<List<Future<TripDriverModel>>>, String)>>
      findDrivers({
    required String passengerId,
    required TripType tripType,
    required LatLng pickupLocation,
    required LatLng destinationLocation,
    required int price,
    required int expectedTime,
    required int distance,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        (Stream<List<Future<TripDriverModel>>>, String) offersStream =
            await _remoteDataSource
                .findDrivers(
          passengerId: passengerId,
          tripType: tripType,
          pickupLocation: pickupLocation,
          destinationLocation: destinationLocation,
          price: price,
          expectedTime: expectedTime,
          distance: distance,
        )
                .then(
          (tripStream) {
            return (
              tripStream.$1.map(
                (offers) {
                  return offers.map(
                    (offer) async {
                      return await _remoteDataSource
                          .getUserById(offer['id'])
                          .then(
                        (driver) async {
                          driver['id'] = offer['id'];
                          driver['price'] = offer['price'];
                          driver['location'] = offer['location'];
                          driver['time'] =
                              (await _remoteDataSource.calculateTwoPoints(
                            LatLng(
                              offer['coordinates'].latitude,
                              offer['coordinates'].longitude,
                            ),
                            pickupLocation,
                          ))['time'];
                          driver['image_path'] ??= ImageAssets.unknownUserImage;
                          return TripDriverModel.fromMap(driver);
                        },
                      );
                    },
                  ).toList();
                },
              ),
              tripStream.$2,
            );
          },
        );
        return Right(offersStream);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> calculateTwoPoints({
    required LatLng pointA,
    required LatLng pointB,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        Map<String, dynamic> res =
            await _remoteDataSource.calculateTwoPoints(pointA, pointB);
        return Right(res);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> cancelTrip(String tripId) async {
    try {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.cancelTrip(tripId);
        return const Right(null);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<void> _storeCurrentUser({String? email, String? phoneNumber}) async {
    Map<String, dynamic> userData = await _remoteDataSource.getUserData(
      email: email,
      phoneNumber: phoneNumber,
    );
    userData['created_at'] = userData['created_at'].toString();
    _cacheDataSource.setCurrentUser(userData);
    if (userData['type'] == 'passenger') {
      _userManager.setCurrentPassenger(PassengerModel.fromMap(userData));
    } else {
      _userManager.setCurrentDriver(DriverModel.fromMap(userData));
    }
  }

  @override
  Either<Failure, void> getCurrentUser() {
    try {
      Map<String, dynamic>? userData = _cacheDataSource.getCurrentUser();
      if (userData != null) {
        if (userData['type'] == 'passenger') {
          _userManager.setCurrentPassenger(PassengerModel.fromMap(userData));
        } else {
          _userManager.setCurrentDriver(DriverModel.fromMap(userData));
        }
      }
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Future<void>>> acceptDriver({
    required String tripId,
    required String driverId,
    required int price,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        Future<void> result = _remoteDataSource.acceptDriver(
          tripId: tripId,
          driverId: driverId,
          price: price,
        );
        return Right(result);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> endTrip(String tripId) async {
    try {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.endTrip(tripId);
        return const Right(null);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, User?>> getSignedUser() async {
    try {
      User? data = _cacheDataSource.getSignedUser();
      getCurrentUser();
      return Right(data);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      void response;
      await _cacheDataSource.logout();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> rate(String userId, int rate) async {
    try {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.rate(userId, rate);
        return const Right(null);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> changeDriverStatus({
    required bool online,
    required String driverId,
    StreamSubscription<LatLng>? coordinatesSubscription,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.changeDriverStatus(
          online: online,
          driverId: driverId,
          coordinatesSubscription: coordinatesSubscription,
        );
        return const Right(null);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Stream<List<(String, Future<TripPassengerModel>)>>>>
      findTrips({
    required LatLng driverLocation,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        // print(-5);
        List<String> tripsIds = [];
        Stream<List<(String, Future<TripPassengerModel>)>> tripsStream =
            _remoteDataSource.findTrips().map(
          (trips) {
            List<String> newTripIds = [];
            List<Future<TripPassengerModel>> futureTrips = trips.map(
              (trip) async {
                // print(-1);
                newTripIds.add(trip['id']);
                // print(tripsIds);
                // print(newTripIds);
                GeoPoint pickupLocation = trip['pickup_location'];
                GeoPoint destinationLocation = trip['destination_location'];
                TripPassengerModel returnedTrip =
                    TripPassengerModel.fromMap(trip);
                if (!tripsIds.contains(trip['id'])) {
                  var user =
                      await _remoteDataSource.getUserById(trip['passenger_id']);
                  Map<String, dynamic> timeCalculations =
                      await _remoteDataSource.calculateTwoPoints(
                    LatLng(
                      pickupLocation.latitude,
                      pickupLocation.longitude,
                    ),
                    driverLocation,
                  );
                  Map<String, dynamic> routeCalculations =
                      await _remoteDataSource.calculateTwoPoints(
                    LatLng(
                      pickupLocation.latitude,
                      pickupLocation.longitude,
                    ),
                    LatLng(
                      destinationLocation.latitude,
                      destinationLocation.longitude,
                    ),
                  );
                  returnedTrip
                    ..setAwayMins = timeCalculations['time']
                    ..setRouteCode = routeCalculations['polylineCode']
                    ..setName = '${user['first_name']} ${user['last_name']}'
                    ..setPassengerRate = user['rate']
                    ..setImagePath =
                        user['image_path'] ?? ImageAssets.unknownUserImage
                    ..setPassengerPhoneNumber = user['phone_number'];
                }
                return returnedTrip;
              },
            ).toList();
            tripsIds.addAll(newTripIds);
            int i = 0;
            return futureTrips.map((futureTrip) {
              // print(i);
              // print(futureTrip);
              // print(newTripIds[i]);
              // print(futureTrip.hashCode);
              return (newTripIds[i++], futureTrip);
            }).toList();
          },
        );
        return Right(tripsStream);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Future<bool>>> acceptTrip({
    required String driverId,
    required String tripId,
    required int price,
    required String location,
    required LatLng coordinates,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        Future<bool> result = _remoteDataSource.acceptTrip(
          tripId: tripId,
          driverId: driverId,
          price: price,
          location: location,
          coordinates: coordinates,
        );
        return Right(result);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> cancelAcceptTrip(
      String driverId, String tripId) async {
    try {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.cancelAcceptTrip(driverId, tripId);
        return const Right(null);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
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
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.addBus(
          driverId: driverId,
          busId: busId,
          firstName: firstName,
          lastName: lastName,
          busLicense: busLicense,
          drivingLicense: drivingLicense,
          nationalID: nationalID,
          phoneNumber: phoneNumber,
          busImage: busImage,
          seatsNumber: seatsNumber,
        );
        return const Right(null);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> addBusTrip(
      {required String driverId,
      required int numberOfBus,
      required double price,
      required String pickupLocation,
      required String destinationLocation,
      required DateTime calendar}) async {
    try {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.addBusTrip(
          driverId: driverId,
          numberOfBus: numberOfBus,
          price: price,
          pickupLocation: pickupLocation,
          destinationLocation: destinationLocation,
          calendar: calendar,
        );
        return const Right(null);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
