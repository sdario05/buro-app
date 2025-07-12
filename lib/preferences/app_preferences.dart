import 'dart:convert';
import 'package:buro_app/features/login/domain/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {

  AppPreferences._privateConstructor();
  static final AppPreferences instance = AppPreferences._privateConstructor();

  Future<SharedPreferences> get _prefs async => await SharedPreferences.getInstance();

  Future<void> saveUser(UserModel user) async {
    final prefs = await _prefs;
    final jsonString = json.encode(user.toJson());
    await prefs.setString('user', jsonString);
  }

  Future<UserModel?> getUser() async {
    final prefs = await _prefs;
    final String? jsonString = prefs.getString('user');

    if (jsonString == null) return null;

    return UserModel.fromJson(json.decode(jsonString));
  }

  Future<void> clearUser() async {
    final prefs = await _prefs;
    await prefs.remove('user');
  }
}