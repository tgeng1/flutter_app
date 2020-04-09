import 'package:flutter/material.dart';

class TaskDetail extends Dialog {
  final Map<String, dynamic> dataInfo;
  TaskDetail({Key key, @required this.dataInfo}) : super(key: key);
  static Future _closeDetailPage(context) async{
    Navigator.pop(context);
  }
  Widget build (BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: MaterialButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: Text('退出'),
            onPressed: () {
              _closeDetailPage(context);
            },
          ),
        ),
      );
  }
}