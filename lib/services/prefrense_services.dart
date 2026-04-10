import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/features/auth/model/user_data_model.dart';

final preferences = SharedPreference();

class SharedPreference {
  static SharedPreferences? _preferences;

  init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  static String accessToken = 'access_token';
  static String login = 'is_login';
  static String idOnBoardDone = 'is_onBoarding';
  static String fcmToken = 'fcmToken';
  static String userData = 'user_data';

  Future<void> setUserData(UserResponse value) async {
    _preferences?.setString(SharedPreference.userData, jsonEncode(value.toJson()));
  }

  UserResponse? getUserData() {
    String? value = _preferences?.getString(SharedPreference.userData);
    if (value != null && value.isNotEmpty) {
      return UserResponse.fromJson(jsonDecode(value));
    }
    return null;
  }

  // removeCheckPointData() async {
  //   _preferences?.remove(SharedPreference.checkPointData);
  // }

  Future<bool?> setString(String key, String value) async {
    return _preferences?.setString(key, value);
  }

  String? getString(String key, {String defValue = ""}) {
    return _preferences == null ? defValue : _preferences!.getString(key) ?? defValue;
  }

  Future<bool?> setInt(String key, int value) async {
    return _preferences?.setInt(key, value);
  }

  int? getInt(String key, {int defValue = 0}) {
    return _preferences == null ? defValue : _preferences!.getInt(key) ?? defValue;
  }

  Future<bool?> setDouble(String key, double value) async {
    return _preferences?.setDouble(key, value);
  }

  double getDouble(String key, {double defValue = 0.0}) {
    return _preferences == null ? defValue : _preferences!.getDouble(key) ?? defValue;
  }

  Future<bool?> setBool(String key, bool value) async {
    return _preferences?.setBool(key, value);
  }

  bool? getBool(String key, {bool defValue = false}) {
    return _preferences == null ? defValue : _preferences!.getBool(key) ?? defValue;
  }

  //NEW ADDED
  Future<bool?> clear({bool defValue = false}) {
    return _preferences!.clear();
  }

  Future<bool?> removePreference(String key) async {
    return _preferences?.remove(key);
  }
}
