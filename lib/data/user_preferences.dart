import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {

  // GET [STRING]
  static Future<String> getDataString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key).toString();
  }

  // SET [STRING]
  static Future<void> setDataString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

}