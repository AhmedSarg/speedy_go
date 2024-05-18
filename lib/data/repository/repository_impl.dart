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
            await fetchCurrentUser();
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
    required String? vehicleModel,
    required String? vehicleColor,
    required String? vehiclePlate,
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
            carModel: vehicleModel!,
            carColor: vehicleColor!,
            carPlate: vehiclePlate!,
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
            tuktukColor: vehicleColor!,
            tuktukPlate: vehiclePlate!,
            createdAt: DateTime.now(),
          );
        } else if (registerType == RegisterType.bus) {
          await _remoteDataSource.registerBusDriverToDataBase(
            uuid: uuid,
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
            email: email,
            nationalId: nationalId!,
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
        await fetchCurrentUser();
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
        await fetchCurrentUser();
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
  Future<Either<Failure, User?>> fetchCurrentUser() async {
    try {
      if (await _networkInfo.isConnected) {
        User? data = _cacheDataSource.getSignedUser();
        if (data != null) {
          Map<String, dynamic> userData = await _remoteDataSource.getUserData(
            email: data.email,
            phoneNumber: data.phoneNumber,
          );
          userData['created_at'] = userData['created_at'].toString();
          if (userData['type'] == 'passenger') {
            _userManager.setCurrentPassenger(PassengerModel.fromMap(userData));
          } else {
            _userManager.setCurrentDriver(DriverModel.fromMap(userData));
          }
        }
        return Right(data);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _cacheDataSource.logout();
      return const Right(null);
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
    required TripType tripType,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        List<String> tripsIds = [];
        Stream<List<(String, Future<TripPassengerModel>)>> tripsStream =
            _remoteDataSource.findTrips(tripType: tripType).map(
          (trips) {
            List<String> newTripIds = [];
            List<Future<TripPassengerModel>> futureTrips = trips.map(
              (trip) async {
                newTripIds.add(trip['id']);
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
    required String busPlate,
    required int busNumber,
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
          busPlate: busPlate,
          busNumber: busNumber,
        );
        await fetchCurrentUser();
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
      required String busId,
      required double price,
      required String pickupLocation,
      required String destinationLocation,
      required DateTime calendar}) async {
    try {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.addBusTrip(
          driverId: driverId,
          busId: busId,
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

  @override
  Future<Either<Failure, Stream<List<Future<TripBusModel>>>>> findBusTrips({
    required String pickup,
    required String destination,
    required DateTime date,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        Stream<List<Future<TripBusModel>>> listOfTrips = _remoteDataSource
            .findBusTrips(pickup: pickup, destination: destination, date: date)
            .map(
              (trips) => trips.map(
                (trip) async {
                  trip['bus'] =
                      await _remoteDataSource.findBusById(trip['bus_id']);
                  trip['available_seats'] =
                      trip['bus']['seats_number'] - trip['taken_seats'];
                  return TripBusModel.fromMap(trip);
                },
              ).toList(),
            );
        return Right(listOfTrips);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Stream<List<BusModel>>>> displayBuses({
    required String driverId,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        Stream<List<BusModel>> listOfBuses =
            _remoteDataSource.displayBuses(driverId: driverId).map(
                  (buses) => buses
                      .map(
                        (bus) => BusModel.fromMap(bus),
                      )
                      .toList(),
                );
        return Right(listOfBuses);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Stream<List<Future<TripBusModel>>>>> busesDriverTrips({
    required String driverId,
    required DateTime date,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        Stream<List<Future<TripBusModel>>> listOfBuses = _remoteDataSource
            .buseDriverTrips(driverId: driverId, date: date)
            .map(
              (trips) => trips.map(
                (trip) async {
                  trip['bus'] =
                      await _remoteDataSource.findBusById(trip['bus_id']);
                  trip['available_seats'] = trip['bus']['seats_number'];
                  return TripBusModel.fromMap(trip);
                },
              ).toList(),
            );
        // print("list $listOfBuses");
        return Right(listOfBuses);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> bookBusTicket({
    required String userId,
    required String busTripId,
    required int seats,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.bookBusTicket(
          userId: userId,
          busTripId: busTripId,
          seats: seats,
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
  Future<Either<Failure, void>> changeAccountInfo({
    required String userId,
    required String firstName,
    required String lastName,
    required bool emailChanged,
    required String email,
    required String phoneNumber,
    required bool pictureChanged,
    File? picture,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        RegisteredBeforeError? registeredBeforeError;
        if (emailChanged) {
          registeredBeforeError =
              await _remoteDataSource.doesUserExists(email: email);
        } else {
          registeredBeforeError = null;
        }
        if (registeredBeforeError == null) {
          await _remoteDataSource.changeAccountInfo(
            userId: userId,
            firstName: firstName,
            lastName: lastName,
            emailChanged: emailChanged,
            email: email,
            phoneNumber: phoneNumber,
            pictureChanged: pictureChanged,
            picture: picture,
          );
          await fetchCurrentUser();
          return const Right(null);
        } else {
          return Left(DataSource.EMAIL_ALREADY_EXISTS.getFailure());
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-token-expired') {
        return Left(DataSource.TOKEN_EXPIRED.getFailure());
      } else if (e.code == 'requires-recent-login') {
        return Left(DataSource.TOKEN_EXPIRED.getFailure());
      }
      return Left(ErrorHandler.handle(e).failure);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> changePassword({
    required String userId,
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        // await _remoteDataSource.changePassword(
        //   userId: userId,
        //   oldPassword: oldPassword,
        //   newPassword: newPassword,
        // );
        await fetchCurrentUser();
        return const Right(null);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, List<HistoryTripModel>>> historyOfTrips(
      {required String id}) async {
    try {
      if (await _networkInfo.isConnected) {
        List<HistoryTripModel> listOfHistoryTrips =
            await _remoteDataSource.historyTrips(id: id).then(
          (trips) {
            return trips.map(
              (trip) {
                return HistoryTripModel.fromMap(trip);
              },
            ).toList();
          },
        );
        return Right(listOfHistoryTrips);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, List<TripBusModel>>> historyOfBusPastTrips({
    required String id,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        List<TripBusModel> listOfHistoryBusPastTrips =
            await _remoteDataSource.historyBusPastTrips(id: id).then(
          (trips) {
            return trips.map(
              (trip) {
                return TripBusModel.fromMap(trip);
              },
            ).toList();
          },
        );
        return Right(listOfHistoryBusPastTrips);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, List<TripBusModel>>> historyOfBusCurrentTrips(
      {required String id}) async {
    try {
      if (await _networkInfo.isConnected) {
        List<TripBusModel> listOfHistoryBusCurrentTrips =
            await _remoteDataSource.historyBusCurrentTrips(id: id).then(
          (trips) {
            return trips.map(
              (trip) {
                return TripBusModel.fromMap(trip);
              },
            ).toList();
          },
        );
        return Right(listOfHistoryBusCurrentTrips);
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
