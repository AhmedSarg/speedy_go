import 'package:firebase_auth/firebase_auth.dart';

import '../network/app_prefs.dart';

const String _currentUser = "currentUser";

abstract class CacheDataSource {
  User? getSignedUser();

  Future<void> logout();
}

class CacheDataSourceImpl implements CacheDataSource {
  final AppPrefs _preferences;
  final FirebaseAuth? _firebaseAuth;

  CacheDataSourceImpl(this._preferences, this._firebaseAuth);

  @override
  User? getSignedUser() {
    return _firebaseAuth?.currentUser;
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth?.signOut();
  }
}
