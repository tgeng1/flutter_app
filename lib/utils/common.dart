import 'package:flutterapp/app.dart';
import 'package:flutterapp/utils/commonUtils.dart';
import 'package:flutterapp/routes/login/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Global {
  static const REST_API_PATH = {
    "DEV": "https://dev-nd.jsure.com/xm-app-backend",
    "TEST": "https://test-nd.jsure.com/xm-app-backend",
    "PRO": "https://nd.jsure.com/xm-app-backend",
    "CLONE": "https://clone-nd.jsure.com/xm-app-backend"
  };
  static String env;
  static String token;
  static int uploadRestApiTimeOut = 12000;
  static String restApiBasePath = REST_API_PATH[env];
  static String userId;

  //config
  static Map xmConfig;
  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    env = await LocalStorageUtil.getInfo('env') ?? 'DEV';
    token ??= await LocalStorageUtil.getInfo('token');

    restApiBasePath = REST_API_PATH[env];
  }

  static Future updateUserData(tokenValue, userIdValue) async{
    var updateToken = await LocalStorageUtil.saveInfo('token', tokenValue);
    var updateUserId = await LocalStorageUtil.saveInfo('userId', userIdValue);
    if (updateUserId == true && updateToken == true) {
      token = tokenValue;
      userId = userIdValue;
      return true;
    } else {
      return false;
    }
  }

  static Future setConfig(configInfo) async {
    xmConfig = configInfo;
  }

  static Future signOut() async{
    await LocalStorageUtil.removeInfo('token');
    await LocalStorageUtil.removeInfo('accessRight');
    token = null;
    xmConfig = null;
    navigatorKey.currentState.pushAndRemoveUntil(
      new MaterialPageRoute(
        builder: (BuildContext context) => new Login()), (
      route) => route == null);
  }

  static void showToast(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
