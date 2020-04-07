import 'package:flutter/material.dart';
import 'package:flutterapp/routes/personal/personal.dart';

class Patient extends StatefulWidget {
  @override
  _PatientState createState() => _PatientState();
}

class _PatientState extends State<Patient> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive =>true;
  void initState() {
    print('---patient------->');
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('患者'),
        actions: <Widget>[
          Icon(Icons.insert_chart),
          Icon(Icons.message)
        ],
      ),
      drawer: Personal(),
      body: Center(child: Text('patient'),),
    );
  }
}