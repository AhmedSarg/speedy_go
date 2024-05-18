import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../presentation/resources/assets_manager.dart';
import 'enums.dart';

///User Model

class UserModel {
  final String uuid;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String imagePath;
  final UserType type;

  UserModel({
    required this.uuid,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.imagePath,
    required this.type,
  });

  factory UserModel.fake() => UserModel(
        uuid: '',
        firstName: '',
        lastName: '',
        phoneNumber: '',
        email: '',
        imagePath: ImageAssets.unknownUserImage,
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
    required super.imagePath,
    required this.gender,
    super.type = UserType.passenger,
  });

  factory PassengerModel.fake() => PassengerModel(
        uuid: '',
        firstName: '',
        lastName: '',
        phoneNumber: '',
        email: '',
        imagePath: ImageAssets.unknownUserImage,
        gender: Gender.male,
      );

  factory PassengerModel.fromMap(Map<String, dynamic> user) {
    return PassengerModel(
      uuid: user['uuid'],
      firstName: user['first_name'],
      lastName: user['last_name'],
      phoneNumber: user['phone_number'],
      email: user['email'],
      imagePath: user['image_path'] ?? ImageAssets.unknownUserImage,
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
  final List<dynamic>? buses;

  DriverModel({
    required super.uuid,
    required super.firstName,
    required super.lastName,
    required super.phoneNumber,
    required super.email,
    required super.imagePath,
    required this.nationalId,
    required this.vehicleType,
    this.buses,
    super.type = UserType.driver,
  });

  factory DriverModel.fake() => DriverModel(
        uuid: '',
        firstName: '',
        lastName: '',
        phoneNumber: '',
        email: '',
        imagePath: ImageAssets.unknownUserImage,
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
      imagePath: data['image_path'] ?? ImageAssets.unknownUserImage,
      nationalId: data['national_id'],
      vehicleType: vehicleType,
      buses: data['buses_ids'] ?? [],
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
  final String imagePath;

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
    required this.imagePath,
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
        imagePath: ImageAssets.unknownUserImage,
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
        imagePath: map['image_path']);
  }
}

class TripPassengerModel {
  final String id;
  final String passengerId;
  late final String passengerName;
  final LatLng pickupLocation;
  final LatLng destinationLocation;
  final int distance;
  final int expectedTime;
  late final int awayMins;
  late final String imagePath;
  late final double passengerRate;
  late final String passengerPhoneNumber;
  late final String routeCode;
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

  set setName(String name) {
    passengerName = name;
  }

  set setAwayMins(int awayMins) {
    this.awayMins = awayMins;
  }

  set setImagePath(String imagePath) {
    this.imagePath = imagePath;
  }

  set setPassengerRate(double passengerRate) {
    this.passengerRate = passengerRate;
  }

  set setPassengerPhoneNumber(String phoneNumber) {
    passengerPhoneNumber = phoneNumber;
  }

  set setRouteCode(String routeCode) {
    this.routeCode = routeCode;
  }

  factory TripPassengerModel.fake() => TripPassengerModel(
        id: '',
        passengerId: '',
        pickupLocation: const LatLng(0, 0),
        destinationLocation: const LatLng(0, 0),
        distance: -1,
        expectedTime: -1,
        price: -1,
      )
        ..setName = ''
        ..setAwayMins = -1
        ..setPassengerRate = -1
        ..setImagePath = ImageAssets.unknownUserImage;

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
      expectedTime: map['expectedTime'].toInt(),
      price: map['price'].toInt(),
    );
  }
}

class HistoryTripModel {
  final String id;
  final LatLng pickupLocation;
  final LatLng destinationLocation;
  final int price;
  final DateTime date;
  late final String pickupAddress;
  late final String destinationAddress;

  HistoryTripModel({
    required this.id,
    required this.pickupLocation,
    required this.destinationLocation,
    required this.price,
    required this.date,
  });

  set setPickupAddress(String address) {
    pickupAddress = address;
  }

  set setDestinationAddress(String address) {
    destinationAddress = address;
  }

  factory HistoryTripModel.fake() => HistoryTripModel(
        id: '',
        pickupLocation: const LatLng(0, 0),
        destinationLocation: const LatLng(0, 0),
        price: -1,
        date: DateTime.now(),
      );

  factory HistoryTripModel.fromMap(Map<String, dynamic> map) {
    LatLng pickupLocation = LatLng(
      (map['pickup_location'] as GeoPoint).latitude,
      (map['pickup_location'] as GeoPoint).longitude,
    );
    LatLng destinationLocation = LatLng(
      (map['destination_location'] as GeoPoint).latitude,
      (map['destination_location'] as GeoPoint).longitude,
    );
    return HistoryTripModel(
      id: map['id'],
      pickupLocation: pickupLocation,
      destinationLocation: destinationLocation,
      price: map['price'].toInt(),
      date: (map['date'] as Timestamp).toDate(),
    );
  }
}

class TripBusModel {
  final String id;
  final String driverId;
  final String pickup;
  final String destination;
  final DateTime date;
  final int price;
  final int availableSeats;
  final BusModel busModel;

  TripBusModel({
    required this.id,
    required this.driverId,
    required this.pickup,
    required this.destination,
    required this.date,
    required this.price,
    required this.availableSeats,
    required this.busModel,
  });

  factory TripBusModel.fake() => TripBusModel(
        id: '',
        driverId: '',
        pickup: '',
        destination: '',
        date: DateTime(2024),
        price: -1,
        availableSeats: -1,
        busModel: BusModel.fake(),
      );

  factory TripBusModel.fromMap(Map<String, dynamic> map) {
    BusModel busModel;
    if (map['bus'] != null) {
      busModel = BusModel.fromMap(map['bus']);
    } else {
      busModel = BusModel.fake();
    }
    return TripBusModel(
      id: map['id'] ?? '',
      driverId: map['driver_id'],
      pickup: map['pickup_location'],
      destination: map['destination_location'],
      date: map['calendar'].toDate(),
      price: map['price'].toInt(),
      availableSeats: (map['available_seats'] ?? -1).toInt(),
      busModel: busModel,
    );
  }
}

class BusModel {
  final String busId;
  final String driverId;
  final int busNumber;
  final String licensePlate;
  final int? seats;

  BusModel({
    required this.busId,
    required this.driverId,
    required this.busNumber,
    required this.licensePlate,
    required this.seats,
  });

  factory BusModel.fake() => BusModel(
        busId: '',
        driverId: '',
        busNumber: -1,
        seats: -1,
        licensePlate: '',
      );

  factory BusModel.fromMap(Map<String, dynamic> map) => BusModel(
        busId: map['bus_id'],
        driverId: map['driver_id'],
        busNumber: map['bus_number'],
        licensePlate: map['bus_plate'] ?? "ا ب ح 2 3 4",
        seats: map['seats_number'],
      );
}
