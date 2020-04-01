import 'package:dio/dio.dart';
import 'package:flutterapp/utils/common.dart';


class HttpUtil {
  String method;
  static int uploadRestApiTimeOut = Global.uploadRestApiTimeOut;
  static String token;

  static HttpUtil instance;
  Dio dio;
  static BaseOptions options;
  CancelToken _cancelToken = new CancelToken();

  static HttpUtil getInstance() {
    if (null == instance) instance = new HttpUtil();
    return instance;
  }

  static Response response;


  HttpUtil() {
    String restApiBasePath = Global.restApiBasePath;
    token ??= Global.token;
    options = new BaseOptions(
      baseUrl: restApiBasePath,
      connectTimeout: uploadRestApiTimeOut,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'x-access-token': token
      },
      contentType: Headers.formUrlEncodedContentType,
      responseType: ResponseType.json
    );
    dio = new Dio(options);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        return options;
      },
      onResponse: (Response response) async {
        return response;
      },
      onError: (DioError e) async {
        if (e.response.statusCode == 401) {
          Global.signOutAboutNotAccess();
          return null;
        } else {
          return e;
        }
      }
    ));
  }

  Future<Map<String, dynamic>> call(method, url, isToken, {data, options}) async{
    if (method == 'get') {
      dio.options.headers = {
        'Accept': 'application/json',
        'x-access-token': token
      };
    }
    try{
      if (method == 'get') {
        response = await dio.get<Map<String, dynamic>>(url, options: options, cancelToken: _cancelToken);
      } else if (method == 'post') {
        response = await dio.post<Map<String, dynamic>>(url, data: data, options: options, cancelToken: _cancelToken);
      } else if(method == 'put') {
        response = await dio.put<Map<String, dynamic>>(url, data: data, options: options, cancelToken: _cancelToken);
      } else if(method == 'delete') {
        response = await dio.delete<Map<String, dynamic>>(url, options: options, cancelToken: _cancelToken);
      } else if(method == 'patch') {
        response = await dio.patch<Map<String, dynamic>>(url, data: data, options: options, cancelToken: _cancelToken);
      }
      return response.data;
    } on DioError catch(e){
      if (e.response != null) {
        print('------err--------');
        print(e.response);
        print(e.response.statusCode);
        return {
          'errInfo': e.response
        };
      } else {
        print(e.message);
        print(e.request);
        return {
          'msg': e.message,
          'req': e.request
        };
      }
    }
  }
}