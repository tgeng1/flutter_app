import 'package:flutter/material.dart';
import 'package:flutterapp/routes/personal/personal.dart';
import './taskApi.dart';
import 'package:flutterapp/components/customLoading.dart';
import 'package:flutterapp/components/customButton.dart';
import './taskDetail.dart';
import 'package:date_format/date_format.dart';
class Task extends StatefulWidget {
  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> with AutomaticKeepAliveClientMixin{
  static List<dynamic> _taskList = [];
  static var today = DateTime.now();
  static var _startTime = DateTime(today.year, today.month, 1).millisecondsSinceEpoch;
  static var _endTime = today.add(Duration(days: 1)).millisecondsSinceEpoch;
  static bool _sortByCompleteness = false;
  static int _pageSize = 10;
  static int _pageNo = 1;

    // Get task list
  Future _getTasks([bool _isLoadMore = false]) async{
    // Get startTime and endTime
    Map<String, dynamic> apiData = {
      'startTime': _startTime,
      'endTime': _endTime,
      'sortByCompleteness': _sortByCompleteness,
      'pageSize': _pageSize,
      'pageNo': _pageNo
    };
    Map<String, dynamic> _result = await TaskApi.getTasks(apiData);
    if (_result['code'] == 'success') {
      List<dynamic> _listData = _result['payload']['Tasks'];
      if (_isLoadMore) {
        _taskList.addAll(_listData);
      } else {
        _taskList = _listData;
      }
      return _listData;
    }
  }

  void _showDetail() {
    showDialog(context: context, builder: (context) => TaskDetail(dataInfo: {},));
  }
  Widget _text(_text, _fontWeight, _fontSize) {
    return Text(
      _text,
      style: TextStyle(
        color: Colors.white,
        fontWeight: _fontWeight,
        fontSize: _fontSize
      ),
    );
  }

  Widget _taskItem(_taskInfo) {
    String _trialName = _taskInfo['trial']['name'] ?? '--';
    String _targetNum = _taskInfo['targetNum'].toString() ?? '--';
    String _completeNum = _taskInfo['completeNum'].toString() ?? '--';
    String _completeness = (_taskInfo['completeness'] * 100).toString() + '%';

    String _taskStatusText = "进行中";
    var _nowTime = DateTime(today.year, today.month, 1).millisecondsSinceEpoch;
    var _ctime = DateTime.parse(_taskInfo['ctime']).millisecondsSinceEpoch;
    if (_taskInfo['completeNum'] >= _taskInfo['targetNum']) {
      _taskStatusText = "已完成";
    } else if (_taskInfo['completeNum'] < _taskInfo['targetNum'] && _ctime < _nowTime) {
      _taskStatusText = "未完成";
    }

    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        gradient: LinearGradient(
          colors: [Color(0xFF1B9FB9), Color(0xFF1A7CBA)],
          begin: FractionalOffset(0, 0),
          end: FractionalOffset(0, 1) 
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _text(_trialName, FontWeight.w800, 20.0),
          _text(_completeness, FontWeight.w800, 30.0),
          _text(_taskStatusText, FontWeight.w800, 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _text('指标数: $_targetNum', FontWeight.w400, 15.0),
              _text('完成数: $_completeNum', FontWeight.w400, 15.0),
            ],
          ),
          CustomButton(text: '查看项目详情', pressed: _showDetail, width: double.infinity, textColor: Colors.black, color: Colors.white,),
        ],
      ),
    );
  }
  
  @override
  bool get wantKeepAlive =>true;
  void initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('任务'),
        actions: <Widget>[
          Icon(Icons.insert_chart),
          Icon(Icons.message)
        ],
      ),
      drawer: Personal(),
      body: RefreshIndicator(
        child: FutureBuilder(
          future: _getTasks(),
          initialData: [],
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: _taskList.length,
                  itemExtent: 250.0,
                  itemBuilder: (BuildContext context, int index) {
                    return _taskItem(_taskList[index]);
                  }
                );
              }
            } else {
              // loading
              return CustomLoading(text: '加载中...',);
            }
          },
        ),
        onRefresh: _getTasks,
      )
    );
  }
}