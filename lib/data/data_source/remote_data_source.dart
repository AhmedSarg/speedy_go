import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:speedy_go/domain/models/enums.dart';

abstract class RemoteDataSource {
  Future<RegisteredBeforeError?> doesUserExists({
    required String email,
    required String phoneNumber,
    required RegisterType registerType,
  });

  Future<Stream<FirebaseAuthException?>> verifyPhoneNumber({
    required String email,
    required String password,
    required String phoneNumber,
    required Stream<String?> otpStream,
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

  Future<void> loginWithPhoneNumber({
    required String phoneNumber,
  });

  Future<void> loginWithEmailPassword({
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
  Future<RegisteredBeforeError?> doesUserExists({
    required String email,
    required String phoneNumber,
    required RegisterType registerType,
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
      'created_at': createdAt,
      'type': 'tuktuk_driver',
    });
    await _firebaseStorage.ref('tuktuk_images').child(tukTukImageName).putFile(
          tukTukImage,
          SettableMetadata(contentType: 'image/jpeg'),
        );
  }

  @override
  Future<void> loginWithPhoneNumber({
    required String phoneNumber,
  }) async {
    await _firebaseAuth.signInWithPhoneNumber(phoneNumber);
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
}
