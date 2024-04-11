import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/models/enums.dart';

class DataIntent {
  DataIntent._();

//------------------------------------
  //Selection
  static Selection _selection = Selection.none;

  static void setSelection(Selection item) => _selection = item;

  static Selection getSelection() {
    return _selection;
  }

//-----------------------------------

//------------------------------------
  //Verification

  // static late Stream<FirebaseAuthException?> _errorStream;
  //
  // static void setErrorStream(Stream<FirebaseAuthException?> errorStream) => _errorStream = errorStream;
  //
  // static Stream<FirebaseAuthException?> getErrorStream() {
  //   return _errorStream;
  // }
  //
  // static late StreamController<String?> _otpStreamController;
  //
  // static void setOtpStreamController(StreamController<String?> otpStreamController) => _otpStreamController = otpStreamController;
  //
  // static StreamController<String?> getOtpStreamController() {
  //   return _otpStreamController;
  // }
  //
  // static late String _verificationSuccessMessage;
  //
  // static void setVerificationSuccessMessage(String verificationSuccessMessage) => _verificationSuccessMessage = verificationSuccessMessage;
  //
  // static String getVerificationSuccessMessage() {
  //   return _verificationSuccessMessage;
  // }

  static String? _phoneNumber;

  static void pushPhoneNumber(String phoneNumber) => _phoneNumber = phoneNumber;

  static String popPhoneNumber() {
    String value = _phoneNumber!;
    _phoneNumber = null;
    return value;
  }

  static String? _email;

  static void pushEmail(String email) => _email = email;

  static String? popEmail() {
    String? value = _email;
    _email = null;
    return value;
  }

  static String? _password;

  static void pushPassword(String password) => _password = password;

  static String? popPassword() {
    String? value = _password;
    _password = null;
    return value;
  }

  static late AuthType _authType;

  static void setAuthType(AuthType authType) => _authType = authType;

  static AuthType getAuthType() {
    return _authType;
  }
  static late Function() _onVerified;

  static void setOnVerified(Function() onVerified) => _onVerified = onVerified;

  static Function() getOnVerified() {
    return _onVerified;
  }

//-----------------------------------
}
