library commonUtils;
import 'package:shared_preferences/shared_preferences.dart';


class LocalStorageUtil {

  static Future<String> getInfo(String keyName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String data = await sharedPreferences.getString(keyName);
    return data;
  }

  static Future<bool> saveInfo(String keyName, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isOk = await sharedPreferences.setString(keyName, value);
    return isOk;
  }
}
