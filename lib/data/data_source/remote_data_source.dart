import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:speedy_go/domain/models/enums.dart';

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

  AuthCredential registerEmailPasswordToAuth({
    required String email,
    required String password,
  });

  Future<Stream<FirebaseAuthException?>> verifyPhoneNumber({
    required String email,
    required String password,
    required String phoneNumber,
    required Stream<String?> otpStream,
  });

  // Future<void> login({
  //   required String email,
  //   required String password,
  // });

  Future<RegisteredBeforeError?> doesUserExists({
    required String email,
    required String phoneNumber,
    required RegisterType registerType,
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
  Future<RegisteredBeforeError?> doesUserExists({
    required String email,
    required String phoneNumber,
    required RegisterType registerType,
  }) async {
    bool phoneNumberUsed = false;
    bool emailUsed = false;
    String collection;
    switch (registerType) {
      case RegisterType.car:
        collection = 'car_drivers';
        break;
      case RegisterType.passenger:
        collection = 'passengers';
        break;
      case RegisterType.tuktuk:
        collection = 'tuktuk_drivers';
        break;
      case RegisterType.bus:
        collection = 'bus_drivers';
        break;
    }
    await _firestore
        .collection(collection)
        .where('phone_number', isEqualTo: phoneNumber)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        phoneNumberUsed = true;
      }
    });
    await _firestore
        .collection(collection)
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
    required String email,
    required String password,
    required String phoneNumber,
    required Stream<String?> otpStream,
  }) async {
    StreamController<FirebaseAuthException?> errorStreamController =
        StreamController<FirebaseAuthException?>.broadcast();
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+20${phoneNumber.substring(1)}',
      verificationCompleted: (phoneAuthCredential) async {
        UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        AuthCredential emailAuthCredential =
            registerEmailPasswordToAuth(email: email, password: password);
        await userCredential.user!.linkWithCredential(emailAuthCredential);
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
                AuthCredential emailAuthCredential =
                    registerEmailPasswordToAuth(
                        email: email, password: password);
                await userCredential.user!
                    .linkWithCredential(emailAuthCredential);
                errorStreamController.add(null);
              } catch (e) {
                errorStreamController.add(e as FirebaseAuthException);
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

// @override
// Future<void> login({
//   required String email,
//   required String password,
// }) async {
//   await _firebaseAuth.signInWithEmailAndPassword(
//     email: email,
//     password: password,
//   );
// }
}
