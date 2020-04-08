import 'package:flutter/material.dart';
import 'package:flutterapp/routes/personal/personal.dart';
import './taskApi.dart';
import 'package:flutterapp/components/customLoading.dart';
class Task extends StatefulWidget {
  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> with AutomaticKeepAliveClientMixin{
  static var today = DateTime.now();
  static var _startTime = today.subtract(Duration(days: 30)).millisecondsSinceEpoch;
  static var _endTime = today.add(Duration(days: 1)).millisecondsSinceEpoch;
  static bool _sortByCompleteness = false;
  static int _pageSize = 10;
  static int _pageNo = 1;

    // Get task list
  Future _getTasks() async{
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
      return _listData;
    }
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
      body: Center(
        child: FutureBuilder(
          future: _getTasks(),
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
                    return Text('$index');
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