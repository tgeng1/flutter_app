import 'package:flutterapp/api/taskServiceApi.dart';
import 'package:flutterapp/api/httpCode/index.dart';
class TaskApi {

  // Get task list
  static Future getTasks(listData) async{
    try {
      // Call edit password api
      var result = await TaskServiceApi.getTasks(listData['startTime'], listData['endTime'], listData['sortByCompleteness'], listData['pageSize'], listData['pageNo']);

      // Return data processing
      switch (result['code']) {
        case HttpCode.CODE_SUCCESS:
          return {
            'code': 'success',
            'msg': result['msg'],
            'payload': result['payload']
          };
        default:
          return {
            'code': 'error',
            'msg': '服务器错误，稍后重试！'
          };
      }
    } catch (err) { // Error processing
      if (err['code'] == HttpCode.CODE_NO_NETWORK) {
        return {
          'code': 'error',
          'msg': "网络异常，请稍后再试"
        };
      } else {
        return {
          'code': 'error',
          'msg': "服务器出错，请稍后再试"
        };
      }
    }
  }
}