import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static const _kUsernameKey = 'username';
  static const _kPasswordKey = 'password';

  Future<void> saveLoginData(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kUsernameKey, username);
    await prefs.setString(_kPasswordKey, password);
  }

  Future<Map<String, String>> getLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString(_kUsernameKey) ?? '';
    final password = prefs.getString(_kPasswordKey) ?? '';
    return {'username': username, 'password': password};
  }
}
