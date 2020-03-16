import 'package:dio/dio.dart';
final REST_API_PATH = {
  "localhost:8000": "https://dev-nd.jsure.com/xm-app-backend",
  "dev-xm.jsure.com": "https://dev-nd.jsure.com/xm-app-backend",
  "test-xm.jsure.com": "https://test-nd.jsure.com/xm-app-backend",
  "xm.jsure.com": "https://nd.jsure.com/xm-app-backend",
  "clone-xm.jsure.com": "https://clone-nd.jsure.com/xm-app-backend"
};

String host = 'localhost:8000';
final String BASE_URL = REST_API_PATH[host];
final int TIMEOUT = 10000;

void getHttp() async {
  try {
    Response response = await Dio().get("http://www.baidu.com");
    print(response);
  } catch (e) {
    print(e);
  }
}
