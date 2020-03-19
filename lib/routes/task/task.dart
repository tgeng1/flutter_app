import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  @override
  createState() => TaskState();
}

class TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '任务'
        ),
      ),
    );
  }
}