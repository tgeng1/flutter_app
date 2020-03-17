import 'package:dio/dio.dart';
import 'package:flutterapp/utils/commonUtils.dart';
const REST_API_PATH = {
  "DEV": "https://dev-nd.jsure.com/xm-app-backend",
  "TEST": "https://test-nd.jsure.com/xm-app-backend",
  "PRO": "https://nd.jsure.com/xm-app-backend",
  "CLONE": "https://clone-nd.jsure.com/xm-app-backend"
};

class HttpUtil {

  String token = '';
  String method, url;
  Map<String, dynamic> _headers, data;


  static HttpUtil instance;
  Dio dio;
  static BaseOptions options;
  CancelToken cancelToken = new CancelToken();

  static HttpUtil getInstance() {
    if (null == instance) instance = new HttpUtil();
    return instance;
  }

  static String env = 'DEV';
  static int uploadRestApiTimeOut = 12000;
  static String restApiBasePath = REST_API_PATH[env];
  static Response response;


  HttpUtil() {
    LocalStorageUtil.getInfo('env').then((onValue) {
      print('111111111');
      restApiBasePath = REST_API_PATH[onValue];
    }).catchError((onError) {
      print(onError);
      return null;
    });
    LocalStorageUtil.getInfo('token').then((onValue) {
      token = onValue;
    }).catchError((onError) {
      print(onError);
      return null;
    });
    if (method == 'get') {
      _headers = {
        'Accept': 'application/json',
        'x-access-token': token
      };
    } else {
      _headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'x-access-token': token
      };
    }
    options = new BaseOptions(
      baseUrl: restApiBasePath,
      connectTimeout: uploadRestApiTimeOut,
      headers: _headers,
      contentType: Headers.formUrlEncodedContentType,
      responseType: ResponseType.json
    );
    dio = new Dio(options);
  }
  Future<Map<String, dynamic>> call(method, url, data, {options}) async{
    try{
      if (method == 'get') {
        response = await dio.get<Map<String, dynamic>>(url, options: options);
      } else if (method == 'post') {
        response = await dio.post<Map<String, dynamic>>(url, data: data, options: options);
      } else if(method == 'put') {
        response = await dio.put<Map<String, dynamic>>(url, data: data, options: options);
      } else if(method == 'delete') {
        response = await dio.delete<Map<String, dynamic>>(url, options: options);
      } else if(method == 'patch') {
        response = await dio.patch<Map<String, dynamic>>(url, data: data, options: options);
      }
      return response.data;
    }catch(err){
      return err;
    }
  }
}