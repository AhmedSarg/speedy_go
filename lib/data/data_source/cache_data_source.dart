import '../network/app_prefs.dart';

const String _currentUser = "currentUser";

abstract class CacheDataSource {
  Map<String, dynamic>? getCurrentUser();

  Future<void> setCurrentUser(Map<String, dynamic> currentUser);
}

class CacheDataSourceImpl implements CacheDataSource {
  final AppPrefs _preferences;

  CacheDataSourceImpl(this._preferences);

  @override
  Map<String, dynamic>? getCurrentUser() {
    return _preferences.getMap(_currentUser);
  }

  @override
  Future<void> setCurrentUser(Map<String, dynamic> currentUser) async {
    await _preferences.setMap(_currentUser, currentUser);
  }
}
