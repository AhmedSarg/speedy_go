import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/models/enums.dart';

abstract class RemoteDataSource {
  Future<List<Map<String, dynamic>>> historyTrips({
    required String id,
  });

  Future<List<Map<String, dynamic>>> historyBusPastTrips({
    required String id,
    // required DateTime date,
  });

  Future<List<Map<String, dynamic>>> historyBusCurrentTrips({
    required String id,
  });

  Future<RegisteredBeforeError?> doesUserExists({
    String? email,
    String? phoneNumber,
  });

  Future<Stream<FirebaseAuthException?>> verifyPhoneNumber({
    String? email,
    String? password,
    required String phoneNumber,
    required Stream<String?> otpStream,
    required AuthType authType,
  });

  AuthCredential registerEmailPasswordToAuth({
    required String email,
    required String password,
  });

  Future<void> registerPassengerToDataBase({
    required String uuid,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String gender,
    required DateTime createdAt,
  });

  Future<void> registerCarDriverToDataBase({
    required String uuid,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String nationalId,
    required File drivingLicense,
    required File carLicense,
    required File carImage,
    required String carModel,
    required String carColor,
    required String carPlate,
    required DateTime createdAt,
  });

  Future<void> registerTukTukDriverToDataBase({
    required String uuid,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String nationalId,
    required File tukTukImage,
    required String tuktukColor,
    required String tuktukPlate,
    required DateTime createdAt,
  });

  Future<void> registerBusDriverToDataBase({
    required String uuid,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String nationalId,
    required DateTime createdAt,
  });

  Future<void> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<(Stream<List<dynamic>>, String)> findDrivers({
    required String passengerId,
    required TripType tripType,
    required LatLng pickupLocation,
    required LatLng destinationLocation,
    required int price,
    required int expectedTime,
    required int distance,
  });

  Future<Map<String, dynamic>> getUserById(String driverId);

  Future<Map<String, dynamic>> calculateTwoPoints(
      LatLng pickup, LatLng destination);

  Future<void> cancelTrip(String tripId);

  Future<Map<String, dynamic>> getUserData(
      {String? email, String? phoneNumber});

  Future<void> acceptDriver({
    required String tripId,
    required String driverId,
    required int price,
  });

  Future<void> endTrip(String tripId);

  Future<void> rate(String userId, int rate);

  Future<void> changeDriverStatus({
    required bool online,
    required String driverId,
    StreamSubscription<LatLng>? coordinatesSubscription,
  });

  Stream<List<Map<String, dynamic>>> findTrips({
    required TripType tripType,
  });

  Future<bool> acceptTrip({
    required String tripId,
    required String driverId,
    required int price,
    required String location,
    required LatLng coordinates,
  });

  Future<void> cancelAcceptTrip(String driverId, String tripId);

  Future<void> addBus({
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
  });

  Future<void> addBusTrip({
    required String driverId,
    required String busId,
    required double price,
    required String pickupLocation,
    required String destinationLocation,
    required DateTime calendar,
  });

  Stream<List<Map<String, dynamic>>> findBusTrips({
    required String pickup,
    required String destination,
    required DateTime date,
  });

  Future<Map<String, dynamic>> findBusById(String busId);

  Stream<List<Map<String, dynamic>>> displayBuses({
    required String driverId,
  });

  Future<void> bookBusTicket({
    required String userId,
    required String busTripId,
    required int seats,
  });

  Stream<List<Map<String, dynamic>>> buseDriverTrips({
    required String driverId,
    required DateTime date,
  });

  Future<void> changeAccountInfo({
    required String userId,
    required String firstName,
    required String lastName,
    required bool emailChanged,
    required String email,
    required String phoneNumber,
    required bool pictureChanged,
    File? picture,
  });
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;
  final FirebaseStorage _firebaseStorage;

  RemoteDataSourceImpl(
      this._firestore, this._firebaseAuth, this._firebaseStorage);

  @override
  Future<RegisteredBeforeError?> doesUserExists({
    String? email,
    String? phoneNumber,
  }) async {
    bool phoneNumberUsed = false;
    bool emailUsed = false;
    if (phoneNumber != null) {
      await _firestore
          .collection('users')
          .where('phone_number', isEqualTo: phoneNumber)
          .get()
          .then(
        (value) {
          if (value.docs.isNotEmpty) {
            phoneNumberUsed = true;
          }
        },
      );
    }
    if (email != null) {
      await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get()
          .then(
        (value) {
          if (value.docs.isNotEmpty) {
            emailUsed = true;
          }
        },
      );
    }
    if (phoneNumberUsed && emailUsed) {
      return RegisteredBeforeError.emailAndPhoneNumberUsed;
    } else if (emailUsed) {
      return RegisteredBeforeError.emailUsed;
    } else if (phoneNumberUsed) {
      print(2);
      return RegisteredBeforeError.phoneNumberUsed;
    } else {
      return null;
    }
  }

  @override
  AuthCredential registerEmailPasswordToAuth({
    required String email,
    required String password,
  }) {
    AuthCredential authCredential =
        EmailAuthProvider.credential(email: email, password: password);
    return authCredential;
  }

  @override
  Future<Stream<FirebaseAuthException?>> verifyPhoneNumber({
    String? email,
    String? password,
    required String phoneNumber,
    required Stream<String?> otpStream,
    required AuthType authType,
  }) async {
    StreamController<FirebaseAuthException?> errorStreamController =
        StreamController<FirebaseAuthException?>.broadcast();
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) async {
        UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        if (authType == AuthType.register) {
          AuthCredential emailAuthCredential =
              registerEmailPasswordToAuth(email: email!, password: password!);
          await userCredential.user!.linkWithCredential(emailAuthCredential);
        }
        errorStreamController.add(null);
      },
      verificationFailed: (e) {
        errorStreamController.add(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpStream.listen(
          (otp) async {
            if (otp != null) {
              try {
                PhoneAuthCredential phoneAuthCredential =
                    PhoneAuthProvider.credential(
                  verificationId: verificationId,
                  smsCode: otp,
                );
                UserCredential userCredential = await _firebaseAuth
                    .signInWithCredential(phoneAuthCredential);
                if (authType == AuthType.register) {
                  AuthCredential emailAuthCredential =
                      registerEmailPasswordToAuth(
                    email: email!,
                    password: password!,
                  );
                  await userCredential.user!
                      .linkWithCredential(emailAuthCredential);
                }
                errorStreamController.add(null);
              } on FirebaseAuthException catch (e) {
                errorStreamController.add(e);
              } catch (e) {
                if (kDebugMode) {
                  print(e);
                }
              }
            } else {
              errorStreamController.add(
                  FirebaseAuthException(code: 'invalid-verification-code'));
            }
          },
        );
      },
      codeAutoRetrievalTimeout: (_) {},
    );
    return errorStreamController.stream;
  }

  @override
  Future<void> registerPassengerToDataBase({
    required String uuid,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String gender,
    required DateTime createdAt,
  }) async {
    // await _firestore.collection('passengers').doc(uuid).set({
    //   'uuid': uuid,
    //   'first_name': firstName,
    //   'last_name': lastName,
    //   'phone_number': phoneNumber,
    //   'email': email,
    //   'gender': gender,
    //   'created_at': createdAt,
    // });
    await _firestore.collection('users').doc(uuid).set({
      'uuid': uuid,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'email': email,
      'gender': gender,
      'rate': 3.5,
      'number_of_rates': 0,
      'created_at': createdAt,
      'type': 'passenger',
    });
  }

  @override
  Future<void> registerCarDriverToDataBase({
    required String uuid,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String nationalId,
    required File drivingLicense,
    required File carLicense,
    required File carImage,
    required String carModel,
    required String carColor,
    required String carPlate,
    required DateTime createdAt,
  }) async {
    String drivingLicenseName = '${uuid}_driving_license.jpg';
    String carLicenseName = '${uuid}_car_license.jpg';
    String carImageName = '${uuid}_car_image.jpg';
    // await _firestore.collection('car_drivers').doc(uuid).set({
    //   'uuid': uuid,
    //   'first_name': firstName,
    //   'last_name': lastName,
    //   'phone_number': phoneNumber,
    //   'email': email,
    //   'national_id': nationalId,
    //   'driving_license': drivingLicenseName,
    //   'car_license': carLicenseName,
    //   'car_image': carImageName,
    //   'car_model': 'Nissan Sunny',
    //   'vehicle_color': 'red',
    //   'vehicle_license': 'ا ب ت - 1 2 3',
    //   'rate': 3.5,
    //   'number_of_rates': 0,
    //   'created_at': createdAt,
    // });
    await _firestore.collection('users').doc(uuid).set({
      'uuid': uuid,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'email': email,
      'national_id': nationalId,
      'driving_license': drivingLicenseName,
      'car_license': carLicenseName,
      'car_image': carImageName,
      'car_model': carModel,
      'vehicle_color': carColor,
      'vehicle_license': carPlate,
      'rate': 3.5,
      'number_of_rates': 0,
      'created_at': createdAt,
      'type': 'car_driver',
    });
    await _firebaseStorage
        .ref('driving_licenses')
        .child(drivingLicenseName)
        .putFile(
          drivingLicense,
          SettableMetadata(contentType: 'image/jpeg'),
        );
    await _firebaseStorage.ref('car_licenses').child(carLicenseName).putFile(
          carLicense,
          SettableMetadata(contentType: 'image/jpeg'),
        );
    await _firebaseStorage.ref('car_images').child(carImageName).putFile(
          carImage,
          SettableMetadata(contentType: 'image/jpeg'),
        );
  }

  @override
  Future<void> registerTukTukDriverToDataBase({
    required String uuid,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String nationalId,
    required File tukTukImage,
    required String tuktukColor,
    required String tuktukPlate,
    required DateTime createdAt,
  }) async {
    String tukTukImageName = '${uuid}_tuktuk_image.jpg';
    // await _firestore.collection('tuktuk_drivers').doc(uuid).set({
    //   'uuid': uuid,
    //   'first_name': firstName,
    //   'last_name': lastName,
    //   'phone_number': phoneNumber,
    //   'email': email,
    //   'national_id': nationalId,
    //   'tuktuk_image': tukTukImageName,
    //   'vehicle_color': 'red',
    //   'vehicle_license': 'ا ب ت - 1 2 3',
    //   'rate': 3.5,
    //   'number_of_rates': 0,
    //   'created_at': createdAt,
    // });
    await _firestore.collection('users').doc(uuid).set({
      'uuid': uuid,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'email': email,
      'national_id': nationalId,
      'tuktuk_image': tukTukImageName,
      'vehicle_model': 'Tuk-Tuk',
      'vehicle_color': tuktukColor,
      'vehicle_license': tuktukPlate,
      'rate': 3.5,
      'number_of_rates': 0,
      'created_at': createdAt,
      'type': 'tuktuk_driver',
    });
    await _firebaseStorage.ref('tuktuk_images').child(tukTukImageName).putFile(
          tukTukImage,
          SettableMetadata(contentType: 'image/jpeg'),
        );
  }

  @override
  Future<void> registerBusDriverToDataBase({
    required String uuid,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String nationalId,
    required DateTime createdAt,
  }) async {
    await _firestore.collection('users').doc(uuid).set({
      'uuid': uuid,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'email': email,
      'national_id': nationalId,
      'rate': 3.5,
      'number_of_rates': 0,
      'created_at': createdAt,
      'type': 'bus_driver',
    });
  }

  @override
  Future<void> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<(Stream<List>, String)> findDrivers({
    required String passengerId,
    required TripType tripType,
    required LatLng pickupLocation,
    required LatLng destinationLocation,
    required int price,
    required int expectedTime,
    required int distance,
  }) async {
    late Stream<List> driversStream;
    late String tripId;
    await _firestore.collection('available_trips').add({
      'passenger_id': passengerId,
      'pickup_location':
          GeoPoint(pickupLocation.latitude, pickupLocation.longitude),
      'destination_location':
          GeoPoint(destinationLocation.latitude, destinationLocation.longitude),
      'price': price,
      'trip_type': tripType.name,
      'expectedTime': expectedTime,
      'distance': distance,
      'drivers': [],
    }).then((tripRef) {
      tripId = tripRef.id;
      driversStream = tripRef.snapshots().map((event) {
        return event.data()!['drivers'];
      });
    });
    return (driversStream, tripId);
  }

  @override
  Future<Map<String, dynamic>> getUserById(String userId) async {
    return await _firestore
        .collection('users')
        .doc(userId)
        .get()
        .then((value) => value.data()!);
  }

  @override
  Future<Map<String, dynamic>> calculateTwoPoints(
      LatLng pointA, LatLng pointB) async {
    const String baseUrl = "https://router.hereapi.com/v8/";
    const String apiKey = "Vc6Uhd34IMqaeQskoAJOIGbVv2RzpWgrO07T9WYuM9s";
    const String endpoint = "routes";
    const String url = baseUrl + endpoint;
    final dio = Dio();
    Map<String, dynamic> result = {"data": -1};
    await dio.get(url, queryParameters: {
      "apiKey": apiKey,
      "transportMode": "car",
      "origin": "${pointA.latitude},${pointA.longitude}",
      "destination": "${pointB.latitude},${pointB.longitude}",
      "return": "summary,polyline",
    }).then((value) {
      double time =
          value.data["routes"][0]["sections"][0]["summary"]["duration"] / 60;
      int distance =
          value.data["routes"][0]["sections"][0]["summary"]["length"];
      String polylineCode = value.data["routes"][0]["sections"][0]["polyline"];
      result = {
        "time": time.round(),
        "distance": distance,
        "polylineCode": polylineCode,
      };
    });
    return result;
  }

  @override
  Future<void> cancelTrip(String tripId) async {
    await _firestore.collection('available_trips').doc(tripId).delete();
  }

  @override
  Future<Map<String, dynamic>> getUserData({
    String? phoneNumber,
    String? email,
  }) async {
    String key, value;
    if (phoneNumber != null) {
      key = 'phone_number';
      value = phoneNumber;
    } else {
      key = 'email';
      value = email!;
    }
    late Map<String, dynamic> user;
    await _firestore
        .collection('users')
        .where(key, isEqualTo: value)
        .get()
        .then(
      (value) {
        user = value.docs[0].data();
      },
    );
    return user;
  }

  @override
  Future<void> acceptDriver({
    required String tripId,
    required String driverId,
    required int price,
  }) async {
    Completer<void> completer = Completer<void>();
    await _firestore.collection('available_trips').doc(tripId).update({
      'drivers': FieldValue.delete(),
      'driver_id': driverId,
      'price': price,
    });
    DocumentReference<Map<String, dynamic>> doc =
        _firestore.collection('available_trips').doc(tripId);
    await doc.get().then((trip) {
      _firestore.collection('running_trips').doc(trip.id).set(trip.data()!);
    });
    await doc.delete();
    _firestore.collection('running_trips').doc(tripId).snapshots().listen(
      (oldDoc) async {
        if (!oldDoc.exists) {
          completer.complete();
        }
      },
    );
    return completer.future;
  }

  @override
  Future<void> endTrip(String tripId) async {
    DocumentReference<Map<String, dynamic>> doc =
        _firestore.collection('running_trips').doc(tripId);
    await doc.get().then((trip) {
      _firestore.collection('finished_trips').doc(trip.id).set(trip.data()!);
      _firestore.collection('finished_trips').doc(trip.id).update({
        'date': DateTime.now(),
      });
    });
    await doc.delete();
  }

  @override
  Future<void> rate(String userId, int rate) async {
    double? newRate;
    await _firestore.collection('users').doc(userId).get().then((value) {
      num oldRate = value.data()!['rate'];
      num numberOfRates = value.data()!['number_of_rates'];
      newRate = ((oldRate * numberOfRates.toDouble()) + rate.toDouble()) /
          (numberOfRates.toDouble() + 1);
    });
    if (newRate != null) {
      await _firestore.collection('users').doc(userId).update({
        'rate': newRate!,
        'number_of_rates': FieldValue.increment(1),
      });
    }
  }

  @override
  Future<void> changeDriverStatus({
    required bool online,
    required String driverId,
    StreamSubscription<LatLng>? coordinatesSubscription,
  }) async {
    if (online) {
      await _firestore.collection('online_drivers').doc(driverId).set({
        'coordinates': null,
      });
      coordinatesSubscription!.onData(
        (location) async {
          DocumentReference docRef =
              _firestore.collection('online_drivers').doc(driverId);
          DocumentSnapshot doc = await docRef.get();
          if (doc.exists) {
            await docRef.update(
              {
                'coordinates': GeoPoint(location.latitude, location.longitude),
              },
            );
          }
        },
      );
    } else {
      coordinatesSubscription!.cancel();
      await _firestore.collection('online_drivers').doc(driverId).delete();
    }
  }

  @override
  Stream<List<Map<String, dynamic>>> findTrips({
    required TripType tripType,
  }) {
    // print(-4);
    return _firestore
        .collection('available_trips')
        .where('trip_type', isEqualTo: tripType.name)
        .snapshots()
        .map(
      (snapshot) {
        // print(-3);
        return snapshot.docs.map(
          (e) {
            // print(-2);
            // print(e.data());
            Map<String, dynamic> res;
            res = e.data();
            res['id'] = e.id;
            return res;
          },
        ).toList();
      },
    );
  }

  @override
  Future<bool> acceptTrip({
    required String tripId,
    required String driverId,
    required int price,
    required String location,
    required LatLng coordinates,
  }) async {
    Completer<bool> completer = Completer<bool>();
    Map<String, dynamic> driverData = {
      'id': driverId,
      'price': price,
      'location': location,
      'coordinates': GeoPoint(
        coordinates.latitude,
        coordinates.longitude,
      ),
    };
    await _firestore.collection('available_trips').doc(tripId).update(
      {
        'drivers': FieldValue.arrayUnion([driverData]),
      },
    );
    _firestore
        .collection('available_trips')
        .doc(tripId)
        .snapshots()
        .listen((trip) {
      List<dynamic> drivers = trip.data()!['drivers'];
      bool found = false;
      for (Map<String, dynamic> driver in drivers) {
        if (driver['id'] == driverId) {
          found = true;
        }
      }
      if (!found) {
        completer.complete(false);
      }
    });
    _firestore.collection('available_trips').doc(tripId).snapshots().listen(
      (oldDoc) async {
        if (!oldDoc.exists) {
          await _firestore.collection('running_trips').doc(tripId).get().then(
            (value) {
              if (value.exists && value.data()!['driver_id'] == driverId) {
                completer.complete(true);
              }
            },
          );
          completer.complete(false);
        }
      },
    );
    return completer.future;
  }

  @override
  Future<void> cancelAcceptTrip(String driverId, String tripId) async {
    await _firestore.collection('available_trips').doc(tripId).get().then(
      (value) async {
        List<dynamic> drivers = value.data()!['drivers'];
        for (Map<String, dynamic> driver in drivers) {
          if (driver['id'] == driverId) {
            await _firestore.collection('available_trips').doc(tripId).update({
              'drivers': FieldValue.arrayRemove([driver]),
            });
            break;
          }
        }
      },
    );
  }

  @override
  Future<void> addBus({
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
    String busLicenceName = '${busId}_bus_license.jpg';
    String drivingLicenseName = '${busId}_driving_license.jpg';
    String busImageName = '${busId}_bus_image.jpg';
    await _firestore.collection('users').doc(driverId).update({
      "buses_ids": FieldValue.arrayUnion([busId]),
    });
    await _firestore.collection('buses').add(
      {
        'bus_id': busId,
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
        'national_id': nationalID,
        'bus_license': busLicenceName,
        'driving_license': drivingLicenseName,
        'bus_image': busImageName,
        'seats_number': seatsNumber,
        'driver_id': driverId,
        'bus_plate': busPlate,
        'bus_number': busNumber,
      },
    );
    await _firebaseStorage.ref('bus_licenses').child(busLicenceName).putFile(
          busLicense,
          SettableMetadata(contentType: 'image/jpeg'),
        );
    await _firebaseStorage
        .ref('driving_licenses')
        .child(drivingLicenseName)
        .putFile(
          drivingLicense,
          SettableMetadata(contentType: 'image/jpeg'),
        );
    await _firebaseStorage.ref('bus_images').child(busImageName).putFile(
          busImage,
          SettableMetadata(contentType: 'image/jpeg'),
        );
  }

  @override
  Future<void> addBusTrip({
    required String driverId,
    required String busId,
    required double price,
    required String pickupLocation,
    required String destinationLocation,
    required DateTime calendar,
  }) async {
    await _firestore.collection('available_bus_trips').add({
      'driver_id': driverId,
      'bus_id': busId,
      'price': price,
      'pickup_location': pickupLocation,
      'destination_location': destinationLocation,
      'calendar': calendar,
      'passengers': [],
    });
  }

  @override
  Stream<List<Map<String, dynamic>>> findBusTrips({
    required String pickup,
    required String destination,
    required DateTime date,
  }) {
    return _firestore
        .collection('available_bus_trips')
        .where('pickup_location', isEqualTo: pickup)
        .where('destination_location', isEqualTo: destination)
        .where('calendar', isGreaterThanOrEqualTo: Timestamp.fromDate(date))
        .where('calendar',
            isLessThan: Timestamp.fromDate(date.add(const Duration(days: 1))))
        .snapshots()
        .map(
      (busTrip) {
        return busTrip.docs.map(
          (e) {
            Map<String, dynamic> ret = e.data();
            ret['id'] = e.id;
            ret['taken_seats'] = ret['passengers']?.length ?? 0;
            return ret;
          },
        ).toList();
      },
    );
  }

  @override
  Future<Map<String, dynamic>> findBusById(String busId) async {
    return await _firestore
        .collection('buses')
        .where('bus_id', isEqualTo: busId)
        .get()
        .then(
      (value) {
        return value.docs[0].data();
      },
    );
  }

  @override
  Future<void> bookBusTicket({
    required String userId,
    required String busTripId,
    required int seats,
  }) async {
    _firestore.collection('available_bus_trips').doc(busTripId).update(
      {
        'passengers': FieldValue.arrayUnion(
          List.generate(
            seats,
            (index) => '${userId}_${index + 1}',
          ),
        ),
      },
    );
  }

  @override
  Stream<List<Map<String, dynamic>>> displayBuses({
    required String driverId,
  }) {
    return _firestore
        .collection('buses')
        .where('driver_id', isEqualTo: driverId)
        .orderBy('bus_number')
        .snapshots()
        .map(
      (busTrip) {
        return busTrip.docs.map(
          (e) {
            return e.data();
          },
        ).toList();
      },
    );
  }

  @override
  Stream<List<Map<String, dynamic>>> buseDriverTrips({
    required String driverId,
    required DateTime date,
  }) {
    return _firestore
        .collection('available_bus_trips')
        .where('driver_id', isEqualTo: driverId)
        .where('calendar', isGreaterThanOrEqualTo: Timestamp.fromDate(date))
        .where('calendar',
            isLessThan: Timestamp.fromDate(date.add(const Duration(days: 1))))
        .snapshots()
        .map(
      (busTrip) {
        return busTrip.docs.map(
          (e) {
            Map<String, dynamic> ret = e.data();
            ret['id'] = e.id;
            return ret;
          },
        ).toList();
      },
    );
  }

  @override
  Future<void> changeAccountInfo({
    required String userId,
    required String firstName,
    required String lastName,
    required bool emailChanged,
    required String email,
    required String phoneNumber,
    required bool pictureChanged,
    File? picture,
  }) async {
    if (emailChanged) {
      await _firebaseAuth.currentUser!.verifyBeforeUpdateEmail(email);
    }
    DocumentReference docRef = _firestore.collection('users').doc(userId);
    if (pictureChanged) {
      String picturePath = '$userId-picture';
      late TaskSnapshot imageUrl;
      await docRef.get().then(
        (value) async {
          imageUrl = await _firebaseStorage
              .ref('user_images')
              .child(picturePath)
              .putFile(
                picture!,
                SettableMetadata(contentType: 'image/jpeg'),
              );
        },
      );
      await docRef.update({
        'image_path': await imageUrl.ref.getDownloadURL(),
      });
    }
    await docRef.update({
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
    });
  }

  @override
  Future<List<Map<String, dynamic>>> historyTrips({required String id}) async {
    return await _firestore
        .collection('finished_trips')
        .where('passenger_id', isEqualTo: id)
        .get()
        .then(
      (value) {
        return value.docs.map((doc) {
          Map<String, dynamic> ret = doc.data();
          ret['id'] = doc.id;
          return ret;
        }).toList();
      },
    );
  }

  @override
  Future<List<Map<String, dynamic>>> historyBusPastTrips({
    required String id,
  }) async {
    return await _firestore
        .collection('available_bus_trips')
        .where('calendar', isLessThan: Timestamp.fromDate(DateTime.now()))
        .get()
        .then(
      (value) {
        List<Map<String, dynamic>> rets = [];
        for (QueryDocumentSnapshot<Map<String, dynamic>> doc in value.docs) {
          doc.data()['id'] = doc.id;
          List<dynamic> passengerIds = doc.data()['passengers'];
          for (String passenger in passengerIds) {
            if (passenger.contains(id)) {
              rets.add(doc.data());
              break;
            }
          }
        }
        return rets;
      },
    );
  }

  @override
  Future<List<Map<String, dynamic>>> historyBusCurrentTrips(
      {required String id}) async {
    return await _firestore
        .collection('available_bus_trips')
        .where(
          'calendar',
          isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.now()),
        )
        .get()
        .then(
      (value) {
        List<Map<String, dynamic>> rets = [];
        for (QueryDocumentSnapshot<Map<String, dynamic>> doc in value.docs) {
          doc.data()['id'] = doc.id;
          List<dynamic> passengerIds = doc.data()['passengers'];
          for (String passenger in passengerIds) {
            if (passenger.contains(id)) {
              rets.add(doc.data());
              break;
            }
          }
        }
        return rets;
      },
    );
  }
}
