import 'package:flutter/material.dart';
import 'package:flutterapp/app.dart';
import 'package:flutterapp/components/customLoading.dart';
import 'package:flutterapp/routes/task/task.dart';
import 'package:flutterapp/routes/patient/patient.dart';
import 'package:flutterapp/routes/clientAndVisiting/clientAndVisiting.dart';
import 'package:flutterapp/routes/project/project.dart';
import 'package:flutterapp/utils/commonUtils.dart';
import 'package:flutterapp/routes/personal/personal.dart';
import 'package:flutterapp/components/customAppBar.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static void titleFnc() {
    _showLoading();
  }
  static Widget _task = CustomAppBar(titleList: [{'title': '任务', 'fnc': titleFnc}]);
  static Widget _patient = CustomAppBar(titleList: [{'title': '任务', 'fnc': titleFnc}]);
  static Widget _clientAndVisiting = CustomAppBar(titleList: [{'title': '任务', 'fnc': titleFnc}]);
  static Widget _project = CustomAppBar(titleList: [{'title': '任务', 'fnc': titleFnc}]);
  static List<String> _accessRight = [];
  int _currentIndex = 0;
  List<Widget> _titleList = [_task, _patient, _clientAndVisiting, _project];
  List<Widget> _routeList = [Task(), Patient(), ClientAndVisiting(), Project()];
  @override
  void initState(){
    super.initState();

  }

  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  static void _showLoading() {
    showDialog<Null>(
      context: navigatorKey.currentState.overlay.context,
      builder: (context) {
        return CustomLoading(text: '加载中.....');
      }
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _titleList[_currentIndex],
      ),
      drawer: Personal(),
      body: _routeList[_currentIndex],
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