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
  Future<RegisteredBeforeError?> doesUserExists({
    required String email,
    required String phoneNumber,
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
  });

  Future<Map<String, dynamic>> getDriverById(String driverId);

  Future<Map<String, dynamic>> calculateTwoPoints(
      LatLng pickup, LatLng destination);

  Future<void> cancelTrip(String tripId);

  Future<Map<String, dynamic>> getUserData(
      {String? email, String? phoneNumber});
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;
  final FirebaseStorage _firebaseStorage;

  RemoteDataSourceImpl(
      this._firestore, this._firebaseAuth, this._firebaseStorage);

  @override
  Future<RegisteredBeforeError?> doesUserExists({
    required String email,
    required String phoneNumber,
  }) async {
    bool phoneNumberUsed = false;
    bool emailUsed = false;
    await _firestore
        .collection('users')
        .where('phone_number', isEqualTo: phoneNumber)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        phoneNumberUsed = true;
      }
    });
    await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        emailUsed = true;
      }
    });
    if (phoneNumberUsed && emailUsed) {
      return RegisteredBeforeError.emailAndPhoneNumberUsed;
    } else if (emailUsed) {
      return RegisteredBeforeError.emailUsed;
    } else if (phoneNumberUsed) {
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
      phoneNumber: '+20${phoneNumber.substring(1)}',
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
        print('THE ERRORRR');
        print(e);
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
    await _firestore.collection('passengers').doc(uuid).set({
      'uuid': uuid,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'email': email,
      'gender': gender,
      'created_at': createdAt,
    });
    await _firestore.collection('users').doc(uuid).set({
      'uuid': uuid,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'email': email,
      'gender': gender,
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
    required DateTime createdAt,
  }) async {
    String drivingLicenseName = '${uuid}_driving_license.jpg';
    String carLicenseName = '${uuid}_car_license.jpg';
    String carImageName = '${uuid}_car_image.jpg';
    await _firestore.collection('car_drivers').doc(uuid).set({
      'uuid': uuid,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'email': email,
      'national_id': nationalId,
      'driving_license': drivingLicenseName,
      'car_license': carLicenseName,
      'car_image': carImageName,
      'car_model': 'Nissan Sunny',
      'vehicle_color': 'red',
      'vehicle_license': 'ا ب ت - 1 2 3',
      'rate': 3.5,
      'number_of_rates': 0,
      'created_at': createdAt,
    });
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
      'car_model': 'Nissan Sunny',
      'vehicle_color': 'red',
      'vehicle_license': 'ا ب ت - 1 2 3',
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
    required DateTime createdAt,
  }) async {
    String tukTukImageName = '${uuid}_tuktuk_image.jpg';
    await _firestore.collection('tuktuk_drivers').doc(uuid).set({
      'uuid': uuid,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'email': email,
      'national_id': nationalId,
      'tuktuk_image': tukTukImageName,
      'vehicle_color': 'red',
      'vehicle_license': 'ا ب ت - 1 2 3',
      'rate': 3.5,
      'number_of_rates': 0,
      'created_at': createdAt,
    });
    await _firestore.collection('users').doc(uuid).set({
      'uuid': uuid,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'email': email,
      'national_id': nationalId,
      'tuktuk_image': tukTukImageName,
      'vehicle_color': 'red',
      'vehicle_license': 'ا ب ت - 1 2 3',
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
  }) async {
    late Stream<List> driversStream;
    late String tripId;
    await _firestore.collection('available_trips').add({
      'passenger_uuid': passengerId,
      'pickup_location':
          GeoPoint(pickupLocation.latitude, pickupLocation.longitude),
      'destination_location':
          GeoPoint(destinationLocation.latitude, destinationLocation.longitude),
      'price': price,
      'trip_type': tripType.name,
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
  Future<Map<String, dynamic>> getDriverById(String driverId) async {
    return await _firestore
        .collection('users')
        .doc(driverId)
        .get()
        .then((value) => value.data()!);
  }

  @override
  Future<Map<String, dynamic>> calculateTwoPoints(
      LatLng pointA, LatLng pointB) async {
    const String baseUrl = "https://router.hereapi.com/v8/";
    const String apiKey = "DW2EtICUSqlxaWY1Zy2ir8ABPQrq_F6LGh1PDa_qxsc";
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
}
