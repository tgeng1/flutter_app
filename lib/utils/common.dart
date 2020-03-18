import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterapp/utils/commonUtils.dart';
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

  //config
  static Map xmConfig;
  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    String _env = await LocalStorageUtil.getInfo('env');
    env = _env != null ? _env : 'DEV';
    restApiBasePath = REST_API_PATH[env];
    if (token == null) {
      String _token = await LocalStorageUtil.getInfo('token');
      token = _token != null ? _token : '';
    }

  }

  static Future setConfig(configInfo) async {
    xmConfig = configInfo;
  }
}