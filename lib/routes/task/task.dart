import 'package:flutter/material.dart';
import 'package:flutterapp/routes/personal/personal.dart';
import 'package:flutterapp/components/customAppBar.dart';
class Task extends StatefulWidget {
  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  void titleFnc() {
    print('--------任务title---->');
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//      appBar: AppBar(
//        title: CustomAppBar(titleList: [{'title': '任务', 'fnc': titleFnc}]),
//      )
//      drawer: Personal(),
    );
  }
}