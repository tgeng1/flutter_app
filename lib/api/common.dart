import 'package:dio/dio.dart';
import 'package:flutterapp/utils/commonUtils.dart';
const REST_API_PATH = {
  "localhost:8000": "https://dev-nd.jsure.com/xm-app-backend",
  "dev-xm.jsure.com": "https://dev-nd.jsure.com/xm-app-backend",
  "test-xm.jsure.com": "https://test-nd.jsure.com/xm-app-backend",
  "xm.jsure.com": "https://nd.jsure.com/xm-app-backend",
  "clone-xm.jsure.com": "https://clone-nd.jsure.com/xm-app-backend"
};

class HttpUtil {

  String token = '';
  String method, url;
  var _headers, data;


  static HttpUtil instance;
  Dio dio;
  BaseOptions options;
  CancelToken cancelToken = new CancelToken();

  static HttpUtil getInstance() {
    if (null == instance) instance = new HttpUtil();
    return instance;
  }

  static String env = 'localhost:8000';
  static int uploadRestApiTimeOut = 12000;
  static String restApiBasePath = REST_API_PATH[env];
  static Response response;


  HttpUtil() {
    LocalStorageUtil.getInfo('env').then((onValue) {
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
  Future call(method, url, data) async{
    url = restApiBasePath + url;
    print(url);
    try{
      if (method == 'get') {
        response = await dio.get(url);
      } else if (method == 'post') {
        response = await dio.post(url, data: data);
      } else if(method == 'put') {
        response = await dio.put(url, data: data);
      } else if(method == 'delete') {
        response = await dio.delete(url);
      } else if(method == 'patch') {
        response = await dio.patch(url, data: data);
      }
      return {
        'status': response.statusCode,
        'code': response.data.code,
        'message': response.data.msg,
        'payload': response.data.payload
      };
    }catch(err){
      return err;
    }
  }
}