import 'package:amc/Server/api_fetch.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences extends GetxService {
  static late SharedPreferences _preferences;

  Future<Preferences> initial() async {
    try {
      _preferences = await SharedPreferences.getInstance();
    } catch (_) {}
    return this;
  }

  Future<void> setString(String key, String? value) async {
    if (value == null) return;
    try {
      await _preferences.setString(key, value);
    } catch (_) {}
  }

  Future<void> setInt(String key, int value) async {
    try {
      await _preferences.setInt(key, value);
    } catch (_) {}
  }

  Future<void> setBool(String key, bool? value) async {
    if (value == null) return;
    try {
      await _preferences.setBool(key, value);
    } catch (_) {}
  }

  String? getString(String key) {
    try {
      return _preferences.getString(key);
    } catch (_) {}
    return null;
  }

  int? getInt(String key) {
    try {
      return _preferences.getInt(key);
    } catch (_) {}
    return null;
  }

  bool? getBool(String key) {
    try {
      return _preferences.getBool(key);
    } catch (_) {}
    return false;
  }

  static Future<bool> clear() async {
    try {
      ApiFetch.saveFCMToken("logout");
      await 0.delay();
      return await _preferences.clear();
    } catch (_) {}
    return false;
  }
}
