import 'package:flutter/material.dart';

class Patient extends StatefulWidget {
  @override
  createState() => PatientState();
}

class PatientState extends State<Patient> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '患者'
        ),
      ),
    );
  }
}