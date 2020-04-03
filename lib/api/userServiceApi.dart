import 'package:flutterapp/api/common.dart';
class UserServiceApi {
  /**
   * authenticate
   * @param  {[Number]} id [user id]
   * @return {[Object]} response {status: 200, code: 'SUCCESS', message: 'msg', payload: {}}
   */
  static getUserInf(id) async{
    String api = '/userapi/users/$id';
    return await HttpUtil().call('get', api, true);
  }

}
