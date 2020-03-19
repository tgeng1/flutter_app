import 'package:flutter/material.dart';

class Project extends StatefulWidget {
  @override
  createState() => ProjectState();
}

class ProjectState extends State<Project> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '中心'
        ),
      ),
    );
  }
}