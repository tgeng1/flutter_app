import 'package:flutter/material.dart';
import 'package:flutterapp/routes/personal/personal.dart';

class Patient extends StatefulWidget {
  @override
  _PatientState createState() => _PatientState();
}

class _PatientState extends State<Patient> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '患者'
        ),
      ),
      drawer: Personal(),
    );
  }
}