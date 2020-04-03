import 'package:flutter/material.dart';
import 'package:flutterapp/routes/personal/personal.dart';
class Project extends StatefulWidget {
  @override
  _ProjectState createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '中心'
        ),
      ),
      drawer: Personal(),
    );
  }
}