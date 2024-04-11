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
