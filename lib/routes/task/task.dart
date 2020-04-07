import 'package:flutter/material.dart';
import 'package:flutterapp/routes/personal/personal.dart';
class Task extends StatefulWidget {
  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive =>true;
  void initState() {
    print('---task------->');
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
        child: ListView.builder(
          itemCount: 100,
          itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.red),
              ),
              child: Text('这是第$index个'),
            );
          }
        ),
      ),
    );
  }
}