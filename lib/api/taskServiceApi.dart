import 'package:flutterapp/api/common.dart';
class TaskServiceApi {
  /**
   * authenticate
   * @param  {date} startTime the task startTime
   * @param  {date} endTime the task endTime
   * @param  {Boolean} sortByCompleteness list sort
   * @param  {Number} pageSize task list page size
   * @param  {Number} pageNo task list now pageNO
   * @return {Object} response {status: 200, code: 'SUCCESS', message: 'msg', payload: {}}
   */
  static getTasks(startTime, endTime, sortByCompleteness, pageSize, pageNo) async{
    String api = '/taskapi/tasks?startTime=$startTime&endTime=$endTime&sortByCompleteness=$sortByCompleteness&pageSize=$pageSize&pageNo=$pageNo';
    return await HttpUtil().call('get', api, true);
  }

}