import 'package:flutterapp/api/userServiceApi.dart';
import 'package:flutterapp/api/httpCode/index.dart';

class PersonalApi {
  /**
   * Get userInf list
   * @param  {string} id [the user ID]
   * @param  {Object} dispatch [react dispatch method for reducer]
   */
  static Future getUserInf(id) async{
    try {
      // Call get userInf api
      var result = await UserServiceApi.getUserInf(id);

      // Return data processing
      switch (result['code']) {
        case HttpCode.CODE_SUCCESS:
          return {
            'code': 'success',
            'msg': result['msg'],
            'payload': result['payload']
          };
        case HttpCode.USER_IS_NOT_EXIST:
          return {
            'code': HttpCode.USER_IS_NOT_EXIST,
            'msg': '无效用户，请重新登录！'
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