import 'package:firebase_auth/firebase_auth.dart';

import '../network/app_prefs.dart';

const String _currentUser = "currentUser";

abstract class CacheDataSource {
  Map<String, dynamic>? getCurrentUser();
  User? getSignedUser();

  Future<void> setCurrentUser(Map<String, dynamic> currentUser);
}

class CacheDataSourceImpl implements CacheDataSource {
  final AppPrefs _preferences;
  final FirebaseAuth? _firebaseAuth;

  CacheDataSourceImpl(this._preferences, this._firebaseAuth);

  @override
  Map<String, dynamic>? getCurrentUser() {
    return _preferences.getMap(_currentUser);
  }
  @override
  User? getSignedUser() {
    return _firebaseAuth?.currentUser;
  }
  @override
  Future<void> setCurrentUser(Map<String, dynamic> currentUser) async {
    await _preferences.setMap(_currentUser, currentUser);
  }
}
