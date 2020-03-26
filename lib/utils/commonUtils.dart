import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageUtil {

  static Future<String> getInfo(String keyName) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String data = await _pref.getString(keyName);
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

}
