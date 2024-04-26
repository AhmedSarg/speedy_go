import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../domain/models/enums.dart';

class DataIntent {
  DataIntent._();

//------------------------------------
  //Selection
  static UserType _selection = UserType.none;

  static void setSelection(UserType item) => _selection = item;

  static UserType getSelection() {
    return _selection;
  }

//-----------------------------------

//------------------------------------
  //Verification

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

//------------------------------------
  //Passenger Trip

  static LatLng? _pickupLocation;

  static void pushPickupLocation(LatLng pickupLocation) => _pickupLocation = pickupLocation;

  static LatLng popPickupLocation() {
    LatLng value = _pickupLocation!;
    _pickupLocation = null;
    return value;
  }

  static LatLng? _destinationLocation;

  static void pushDestinationLocation(LatLng destinationLocation) => _destinationLocation = destinationLocation;

  static LatLng popDestinationLocation() {
    LatLng value = _destinationLocation!;
    _destinationLocation = null;
    return value;
  }

  static String? _ratedUserId;

  static void pushRatedUserId(String driverId) => _ratedUserId = driverId;

  static String popRatedUserId() {
    String value = _ratedUserId!;
    _ratedUserId = null;
    return value;
  }


//-----------------------------------
}
