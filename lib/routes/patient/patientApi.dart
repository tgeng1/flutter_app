import 'package:flutterapp/api/patientServiceApi.dart';
import 'package:flutterapp/api/httpCode/index.dart';
class PatientApi {
  /**
   * Get subjects
   * @param  {Object} listData    the API data object
   */
  static Future getSubjects(listData) async{
    try {
      // Call get subjects api
      var result = await PatientServiceApi.getSubjects(
        listData['trialID'],
        listData['startTime'],
        listData['endTime'],
        listData['stageName'],
        listData['stageResult'],
        listData['isReserved'],
        listData['name'],
        listData['pageSize'],
        listData['pageNo']
      );

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