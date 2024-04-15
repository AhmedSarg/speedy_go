import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speedy_go/domain/models/enums.dart';

///User Model

class UserModel {
  final String uuid;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;

  UserModel({
    required this.uuid,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
  });

  factory UserModel.fake() => UserModel(
        uuid: '',
        firstName: '',
        lastName: '',
        phoneNumber: '',
        email: '',
      );
}

class PassengerModel extends UserModel {
  final Gender gender;

  PassengerModel({
    required super.uuid,
    required super.firstName,
    required super.lastName,
    required super.phoneNumber,
    required super.email,
    required this.gender,
  });

  factory PassengerModel.fake() => PassengerModel(
        uuid: '',
        firstName: '',
        lastName: '',
        phoneNumber: '',
        email: '',
        gender: Gender.male,
      );
}

class DriverModel extends UserModel {
  final String nationalId;
  final VehicleType vehicleType;
  LatLng? lastKnownLocation;

  DriverModel({
    required super.uuid,
    required super.firstName,
    required super.lastName,
    required super.phoneNumber,
    required super.email,
    required this.nationalId,
    required this.vehicleType,
    this.lastKnownLocation,
  });

  factory DriverModel.fake() => DriverModel(
        uuid: '',
        firstName: '',
        lastName: '',
        phoneNumber: '',
        email: '',
        nationalId: '',
        vehicleType: VehicleType.car,
        lastKnownLocation: const LatLng(-1, -1),
      );

  factory DriverModel.fromMap(Map<String, dynamic> data) {
    VehicleType vehicleType;
    if (data['type'] == 'car_driver') {
      vehicleType = VehicleType.car;
    }
    else if (data['type'] == 'tuktuk_driver') {
      vehicleType = VehicleType.tuktuk;
    }
    else {
      vehicleType = VehicleType.bus;
    }
    return DriverModel(
      uuid: data['uuid'],
      firstName: data['first_name'],
      lastName: data['last_name'],
      phoneNumber: data['phone_number'],
      email: data['email'],
      nationalId: data['national_id'],
      vehicleType: vehicleType,
    );
  }
}

///Trip Screen

class TripDriverModel {
  final int id;
  final String name;
  final String location;
  final int price;
  final String phoneNumber;
  final String car;
  final String color;
  final String license;
  final int rate;
  final int time;

  TripDriverModel({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.phoneNumber,
    required this.car,
    required this.color,
    required this.license,
    required this.rate,
    required this.time,
  });

  factory TripDriverModel.fake() => TripDriverModel(
        id: -1,
        name: '',
        location: '',
        price: -1,
        phoneNumber: '',
        car: '',
        color: '',
        license: '',
        rate: -1,
        time: -1,
      );
}
