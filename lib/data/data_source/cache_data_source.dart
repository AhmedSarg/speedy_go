import 'package:firebase_auth/firebase_auth.dart';

import '../network/app_prefs.dart';

const String _currentUser = "currentUser";

abstract class CacheDataSource {
  Map<String, dynamic>? getCurrentUser();

  User? getSignedUser();

  Future<void> logout();

  Future<void> setCurrentUser(Map<String, dynamic> currentUser);

  Future<void> clearCurrentUser();
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
  Future<void> setCurrentUser(Map<String, dynamic> currentUser) async {
    await _preferences.setMap(_currentUser, currentUser);
  }

  @override
  User? getSignedUser() {
    return _firebaseAuth?.currentUser;
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth?.signOut();
  }

  @override
  Future<void> clearCurrentUser() async {
    await _preferences.removeKey(_currentUser);
  }
}
