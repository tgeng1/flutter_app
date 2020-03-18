library commonUtils;
import 'package:shared_preferences/shared_preferences.dart';


class LocalStorageUtil {

  static Future<String> getInfo(String keyName) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String data = await _pref.getString(keyName);
    return data;
  }

  static Future saveInfo(String keyName, String value) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString(keyName, value);
  }

  static Future saveList(String keyName, List<String> value) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setStringList(keyName, value);
  }
}
