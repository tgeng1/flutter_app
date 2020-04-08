import 'package:flutter/material.dart';
import 'package:flutterapp/routes/personal/personal.dart';
class Project extends StatefulWidget {
  @override
  _ProjectState createState() => _ProjectState();
}

class _ProjectState extends State<Project> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive =>true;
  void initState() {
    print('---site------->');
    super.initState();
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('中心'),
        actions: <Widget>[
          Icon(Icons.insert_chart),
          Icon(Icons.message)
        ],
      ),
      drawer: Personal(),
      body: Center(child: Text('site'),),
    );
  }
}