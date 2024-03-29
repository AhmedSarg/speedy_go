import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class RemoteDataSource {
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

  Future<UserCredential> registerEmailPasswordToAuth({
    required String email,
    required String password,
  });

  Future<void> verifyPhoneNumberForRegister(
    User user,
    String phoneNumber,
  );

  Future<void> login({
    required String email,
    required String password,
  });
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;
  final FirebaseStorage _firebaseStorage;

  RemoteDataSourceImpl(
      this._firestore, this._firebaseAuth, this._firebaseStorage);

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
      'created_at': createdAt,
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
  Future<UserCredential> registerEmailPasswordToAuth({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> verifyPhoneNumberForRegister(
      User user, String phoneNumber) async {
    _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneCredentials) {
        user.linkWithCredential(phoneCredentials);
      },
      verificationFailed: (FirebaseAuthException e) {
        user.delete();
        throw e;
      },
      codeSent: (codeSent, v) {},
      codeAutoRetrievalTimeout: (s) {},
    );
  }

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
