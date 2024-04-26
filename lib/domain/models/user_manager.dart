import 'domain.dart';
import 'enums.dart';

class UserManager {
  PassengerModel? _currentPassenger;

  DriverModel? _currentDriver;

  UserType? _currentUserType;

  PassengerModel? get getCurrentPassenger => _currentPassenger;

  DriverModel? get getCurrentDriver => _currentDriver;

  UserType? get getCurrentUserType => _currentUserType;

  void setCurrentPassenger(PassengerModel passengerModel) {
    _currentPassenger = passengerModel;
    _currentUserType = UserType.passenger;
    _currentDriver = null;
  }

  void setCurrentDriver(DriverModel driverModel) {
    _currentDriver = driverModel;
    _currentUserType = UserType.driver;
    _currentPassenger = null;
  }
}
