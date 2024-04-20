// import 'domain.dart';
//
// class UserManager {
//   UserModel? _currentUser;
//
//   UserModel get currentUser => _currentUser!;
//
//   void setCurrentUser(UserModel user) {
//     _currentUser = user;
//   }
// }
import 'domain.dart';

class UserManager<Type> {
  Type? _currentUser;

  Type? get currentUser => _currentUser;

  void setCurrentUser(Type user) {
    _currentUser = user;
  }
}
