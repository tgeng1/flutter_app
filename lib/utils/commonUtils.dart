import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageUtil {

  static Future<String> getInfo(String keyName) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String data = await _pref.getString(keyName);
    return data;
  }

  static Future<List<String>> getListInfo(String keyName) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    List data = await _pref.getStringList(keyName);
    return data;
  }

  static Future<bool> saveInfo(String keyName, String value) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    bool result = await _pref.setString(keyName, value);
    return result;
  }

  static Future saveList(String keyName, List<String> value) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    bool result = await _pref.setStringList(keyName, value);
    return result;
  }

  static Future removeInfo(String keyName) async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    bool result = await _pref.remove(keyName);
    return result;
  }

  static localPath() async{
    var tempDir = await getApplicationDocumentsDirectory();
    String tempPath = tempDir.path;
    return tempPath;
  }

  static localFile(path) async{
    return new File('$path/xmConfig.json');
  }

  // read json
  static Future<Map<String, dynamic>> readJson() async{
    final file = await localFile(await localPath());
    String str = await file.readAsString();
    Map<String, dynamic> map = json.decode(str);
    return map;
  }

  // write json
  static Future writeJson(map) async{
    final file = await localFile(await localPath());
    return file.writeAsString(jsonEncode(map));
  }

}
