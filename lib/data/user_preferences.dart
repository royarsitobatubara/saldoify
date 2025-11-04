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

  // GET [BOOL]
  static Future<bool> getDataBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  // SET [BOOL]
  static Future<void> setDataBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  // GET [INT]
  static Future<int?> getDataInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }


  // SET [INT]
  static Future<void> setDataInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static Future<void> deleteData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> deleteIsLogin() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('isLogin');
  }

}