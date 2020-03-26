import 'package:flutter/material.dart';
import 'package:flutterapp/routes/login/login.dart';
import 'package:flutterapp/routes/home/home.dart';
import 'package:flutterapp/utils/common.dart';


class App extends StatefulWidget {
  @override
  createState() => new AppState();
}
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
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
      title: 'Welcome to XM APP',
      home: new Container(
        child: startPage(),
      ),
      navigatorKey: navigatorKey,
    );
  }
}