import 'package:flutterapp/api/common.dart';
class PatientServiceApi {

  /**
   * get subjects
   * @param  {[String]} trialID [the trial ID]
   * @param  {[Date]} startTime [the startTime for time limit]
   * @param  {[Date]} endTime [the endTime for time limit]
   * @param  {[String]} stageName [patient stage]
   * @param  {[String]} stageResult [patient result]
   * @param  {[Boolean]} isReserved [patient reserved status]
   * @param  {[String]} name [patient name or phone]
   * @param  {[Number]} pageSize [task list page size]
   * @param  {[Number]} pageNo [task list now pageNO]
   * @return {[Object]} response {status: 200, code: 'SUCCESS', message: 'msg', payload: {}}
   */
  static getSubjects(trialID, startTime, endTime, stageName, stageResult, isReserved, name, pageSize, pageNo) async{
    String _name = Uri.encodeComponent(name);
    String api = '/trial_subject_api/trial_subjects?trialID=$trialID&startTime=$startTime&endTime=$endTime&stageName=$stageName&stageResult=$stageResult&isReserved=$isReserved&name=$_name&pageSize=$pageSize&pageNo=$pageNo';
    return await HttpUtil().call('get', api, true);
  }
}