import 'package:flutter/material.dart';
import 'package:flutterapp/routes/login/login.dart';

class App extends StatefulWidget {
  @override
  createState() => new AppState();
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Container(
        child: Login(),
      )
    );
  }
}