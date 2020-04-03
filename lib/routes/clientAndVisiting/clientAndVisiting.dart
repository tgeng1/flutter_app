import 'package:flutter/material.dart';
import 'package:flutterapp/routes/personal/personal.dart';
class ClientAndVisiting extends StatefulWidget {
  @override
  _ClientAndVisitingState createState() => _ClientAndVisitingState();
}

class _ClientAndVisitingState extends State<ClientAndVisiting> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '客户'
        ),
      ),
      drawer: Personal(),
    );
  }
}