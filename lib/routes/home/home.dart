import 'package:flutter/material.dart';
import 'package:flutterapp/routes/task/task.dart';
import 'package:flutterapp/routes/patient/patient.dart';
import 'package:flutterapp/routes/clientAndVisiting/clientAndVisiting.dart';
import 'package:flutterapp/routes/project/project.dart';

class Home extends StatefulWidget {
  @override
  createState() => HomeState();
}

class HomeState extends State<Home> {
  int _currentIndex = 0;
  List<Widget> list = List();
  @override
  void initState(){
    list
      ..add(Task())
      ..add(Patient())
      ..add(ClientAndVisiting())
      ..add(Project());
    super.initState();
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list
            ),
            title: Text(
              '任务'
            )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.list
              ),
              title: Text(
                  '患者'
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.list
              ),
              title: Text(
                  '客户'
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.list
              ),
              title: Text(
                  '中心'
              )
          )
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}