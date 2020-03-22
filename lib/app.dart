import 'package:flutter/material.dart';
import 'package:flutterapp/routes/login/login.dart';
import 'package:flutterapp/routes/home/home.dart';
import 'package:flutterapp/utils/common.dart';
import 'package:flutterapp/utils/commonUtils.dart';


class App extends StatefulWidget {
  @override
  createState() => new AppState();
}

class AppState extends State<App> {

  Widget startPage() {
    if (Global.token == null) {
      return Login();
    } else {
      return Home();
    }
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      navigatorObservers: [CustomNavigatorObService()],
      title: 'Welcome to XM APP',
      home: new Container(
        child: startPage(),
      )
    );
  }
}