import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speedy_go/domain/models/enums.dart';

///User Model

class UserModel {
  final String uuid;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final UserType type;

  UserModel({
    required this.uuid,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.type,
  });

  factory UserModel.fake() => UserModel(
        uuid: '',
        firstName: '',
        lastName: '',
        phoneNumber: '',
        email: '',
        type: UserType.passenger,
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
    super.type = UserType.passenger,
  });

  factory PassengerModel.fake() => PassengerModel(
        uuid: '',
        firstName: '',
        lastName: '',
        phoneNumber: '',
        email: '',
        gender: Gender.male,
      );

  factory PassengerModel.fromMap(Map<String, dynamic> user) {
    return PassengerModel(
      uuid: user['uuid'],
      firstName: user['first_name'],
      lastName: user['last_name'],
      phoneNumber: user['phone_number'],
      email: user['email'],
      gender: user['gender'] == 'female' ? Gender.female : Gender.male,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'email': email,
      'gender': gender == Gender.female ? 'female' : 'male',
      'type': type.name,
    };
  }
}

class DriverModel extends UserModel {
  final String nationalId;
  final VehicleType vehicleType;

  DriverModel({
    required super.uuid,
    required super.firstName,
    required super.lastName,
    required super.phoneNumber,
    required super.email,
    required this.nationalId,
    required this.vehicleType,
    super.type = UserType.driver,
  });

  factory DriverModel.fake() => DriverModel(
        uuid: '',
        firstName: '',
        lastName: '',
        phoneNumber: '',
        email: '',
        nationalId: '',
        vehicleType: VehicleType.car,
      );

  factory DriverModel.fromMap(Map<String, dynamic> data) {
    VehicleType vehicleType;
    if (data['type'] == 'car_driver') {
      vehicleType = VehicleType.car;
    } else if (data['type'] == 'tuktuk_driver') {
      vehicleType = VehicleType.tuktuk;
    } else {
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

  Map<String, dynamic> toMap() {
    String vehicleType;
    if (this.vehicleType == VehicleType.car) {
      vehicleType = 'car_driver';
    } else if (this.vehicleType == VehicleType.tuktuk) {
      vehicleType = 'tuktuk_driver';
    } else {
      vehicleType = 'bus_driver';
    }
    return {
      'uuid': uuid,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'email': email,
      'national_id': nationalId,
      'type': vehicleType,
    };
  }
}

///Trip Screen

class TripDriverModel {
  final String id;
  final String name;
  final String location;
  final int price;
  final String phoneNumber;
  final String car;
  final String color;
  final String license;
  final double rate;
  final int numberOfRates;
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
    required this.numberOfRates,
    required this.time,
  });

  factory TripDriverModel.fake() => TripDriverModel(
        id: '',
        name: '',
        location: '',
        price: -1,
        phoneNumber: '',
        car: '',
        color: '',
        license: '',
        rate: -1,
        numberOfRates: -1,
        time: -1,
      );

  factory TripDriverModel.fromMap(Map<String, dynamic> map) {
    return TripDriverModel(
      id: map['id'],
      name: '${map['first_name']} ${map['last_name']}',
      location: map['location'],
      price: map['price'].toInt(),
      phoneNumber: map['phone_number'],
      car: map['car_model'] ?? 'Tuk Tuk',
      color: map['vehicle_color'],
      license: map['vehicle_license'],
      rate: map['rate'].toDouble(),
      numberOfRates: map['number_of_rates'].toInt(),
      time: map['time'],
    );
  }
}

class TripPassengerModel {
  final String id;
  final String passengerId;
  final LatLng pickupLocation;
  final LatLng destinationLocation;
  final int distance;
  final int expectedTime;
  final int price;

  TripPassengerModel({
    required this.id,
    required this.passengerId,
    required this.pickupLocation,
    required this.destinationLocation,
    required this.distance,
    required this.expectedTime,
    required this.price,
  });

  factory TripPassengerModel.fake() => TripPassengerModel(
        id: '',
        passengerId: '',
        pickupLocation: const LatLng(0, 0),
        destinationLocation: const LatLng(0, 0),
        distance: -1,
        expectedTime: -1,
        price: -1,
      );

  factory TripPassengerModel.fromMap(Map<String, dynamic> map) {
    return TripPassengerModel(
      id: map['id'],
      passengerId: map['passenger_id'],
      pickupLocation: LatLng(
        (map['pickup_location'] as GeoPoint).latitude,
        (map['pickup_location'] as GeoPoint).longitude,
      ),
      destinationLocation: LatLng(
        (map['destination_location'] as GeoPoint).latitude,
        (map['destination_location'] as GeoPoint).longitude,
      ),
      distance: map['distance'].toInt(),
      expectedTime: map['expected_time'].toInt(),
      price: map['price'].toInt(),
    );
  }
}
