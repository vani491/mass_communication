import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> storeUserData(String name, String mobileNumber, String role, String Id) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs?.setString('userName', name);
    await _prefs?.setString('mobileNumber', mobileNumber);
    await _prefs?.setString('role', role);
    await _prefs?.setString('userId', Id);
  }

  static String? getUserName() {
    return _prefs?.getString('userName');
  }

  static String? getMobileNumber() {
    return _prefs?.getString('mobileNumber');
  }

  static String? getRole() {
    return _prefs?.getString('role');
  }

  static String? getUserId() {
    return _prefs?.getString('userId');
  }
}
