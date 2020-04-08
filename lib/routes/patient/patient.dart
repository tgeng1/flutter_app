import 'package:flutter/material.dart';
import 'package:flutterapp/components/customLoading.dart';
import 'package:flutterapp/routes/personal/personal.dart';
import 'package:date_format/date_format.dart';
import './patientApi.dart';

class Patient extends StatefulWidget {
  @override
  _PatientState createState() => _PatientState();
}

class _PatientState extends State<Patient> with AutomaticKeepAliveClientMixin{
  // static List<dynamic> _subjectList = [];
  static var today = DateTime.now();
  static String _trialID = '';
  static var _startTime = today.subtract(Duration(days: 4200)).millisecondsSinceEpoch;
  static var _endTime = today.add(Duration(days: 30)).millisecondsSinceEpoch;
  static String _stageName = '';
  static String _stageResult = '';
  static String _isReserved = '';
  static String _name = '';
  static int _pageSize = 10;
  static int patientPageNo = 1;

  Future _getSubjectList() async{
    Map<String, dynamic> _dataInfo = {
      'trialID': _trialID,
      'startTime': _startTime,
      'endTime': _endTime,
      'stageName': _stageName,
      'stageResult': _stageResult,
      'isReserved': _isReserved,
      'name': _name,
      'pageSize': _pageSize,
      'pageNo': patientPageNo
    };
    Map<String, dynamic> _result = await PatientApi.getSubjects(_dataInfo);
    if (_result.isNotEmpty && _result['code'] == 'success') {
      List<dynamic> _subjectListInfo = _result['payload']['trialSubjects'];
      return _subjectListInfo;
    }
  }

  Map<String, String> _renderAgent(record) {
    String agent = '--';
    String agentName = '--';
    // Judging the transfer of the person in charge
    if (record['agent'] != null && record['agent']['name'] != null) {
      agent = record['agent']['name'];
      agentName = record['agent']['name'];
    }
    if (record['currentAgent'] != null && record['currentAgent']['name'] != null) {
      agent = record['currentAgent']['name'];
      agentName = record['currentAgent']['name'];
    }
    if (record['agent'] != null && record['agent']['name'] != null && record['currentAgent'] != null && record['currentAgent']['name'] != null) {
      if (!record['agent']['update']) {
        agent = record['agent']['name'] + " => " + record['currentAgent']['name'];
        agentName = record['currentAgent']['name'];
      } else {
        agent = record['currentAgent']['name'] + " => " + record['agent']['name'];
        agentName = record['agent']['name'];
      }
    }
    return {
      'agent': agent,
      'agentName': agentName
    };
  }

  Widget _text(_text) {
    return Text(
      _text,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800
      ),
    );
  }

  Widget _subjectItem(_subjectInfo, _index) {
    String _subjectName = _subjectInfo[_index]['subject']['name'] ?? '--';
    Map<String, dynamic> _currentStage = _subjectInfo[_index]['currentStage'] ?? {};
    Map<String, dynamic> _trialInfo = _subjectInfo[_index]['trial'] ?? {};

    String _uTime = _subjectInfo[_index]['utime'];
    var _date = _uTime != null ? formatDate(DateTime.parse(_uTime), [yyyy, '-', mm, '-', dd]) :'--';

    String _agent = _renderAgent(_subjectInfo[_index])['agent'];

    String _stageState = '成功';
    List<Color> _cardColor = [Color(0xFFD37F13), Color(0xFFCFAF02)];

    if (_currentStage.isNotEmpty) {
      if (_currentStage['code'] == 4) {
        _cardColor = [Color(0xFF01AF88), Color(0xFF15C589)];
      }
      if (_currentStage['result'] == 'failed') {
        _cardColor = [Color(0xFF8F959C), Color(0xFFA5AFB8)];
        _stageState = '失败';
      }
      if (_currentStage['result'] == 'ongoing') {
        _cardColor = [Color(0xFF1A7CBA), Color(0xFF1B9FB9)];
        _stageState = '有待跟进';
      }
    }
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        gradient: LinearGradient(
          colors: _cardColor,
          begin: FractionalOffset(0, 0),
          end: FractionalOffset(0, 1) 
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _text(_subjectName),
                _text(_trialInfo['name'] ?? '--'),
                _text(_date),
                _text('负责人: $_agent'),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Image.asset('images/patientImages/step1.png', width: 30.0, height: 30.0,),
                ),
                Expanded(
                  flex: 1,
                  child: _text(_currentStage['name'] + _stageState),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive =>true;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('患者'),
        actions: <Widget>[
          Icon(Icons.insert_chart),
          Icon(Icons.message)
        ],
      ),
      drawer: Personal(),
      body: Center(
        child: FutureBuilder(
          future: _getSubjectList(),
          initialData: [],
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemExtent: 155.0,
                  itemBuilder: (BuildContext context, int index) {
                    return _subjectItem(snapshot.data, index);
                  }
                );
              }
            } else {
              // loading
              return CustomLoading(text: '加载中.....',);
            }
          },
        ),
      ),
    );
  }
}