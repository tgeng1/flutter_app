import 'package:flutterapp/api/common.dart';

class LoginServiceApi {

  /**
   * authenticate
   * @param  {[String]} phone [the login user phone]
   * @param  {[String]} password [the login user password]
   * @return {[Object]} response {status: 200, code: 'SUCCESS', message: 'msg', payload: {}}
   */
  static userLogin(phone, password) async{
    const api = '/userapi/users/authenticate';
    var body = {
      "phone": phone.trim(),
      "password": password.trim()
    };

    return await HttpUtil().call('post', api, false, data: body);
  }

  /**
   * get user access
   * @return {[Object]} response {status: 200, code: 'SUCCESS', message: 'msg', payload: {}}
   */
  static getUserAccess() async{
    const api = '/userapi/users/access?kind=APP';
    return await HttpUtil().call('get', api, true);
  }

  /**
   * get config
   * @return {[Object]} response {status: 200, code: 'SUCCESS', message: 'msg', payload: {}}
   */
  static getConfig() async{
    const api = '/statisticalapi/config/map';
    return await HttpUtil().call('get', api, true);
  }
}