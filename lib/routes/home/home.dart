import 'package:flutter/material.dart';
import 'package:flutterapp/app.dart';
import 'package:flutterapp/components/customLoading.dart';
import 'package:flutterapp/routes/task/task.dart';
import 'package:flutterapp/routes/patient/patient.dart';
import 'package:flutterapp/routes/clientAndVisiting/clientAndVisiting.dart';
import 'package:flutterapp/routes/project/project.dart';
import 'package:flutterapp/utils/commonUtils.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _homePageController = PageController();
  int _currentIndex = 0;
  static List<Widget> _routeList;
  static List<BottomNavigationBarItem> _bottomNavigationBarList;
  
  static void titleFnc() {
    _showLoading();
  }
  static _bottomBarItem(icon, title) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon
      ),
      title: Text(
        title
      )
    );
  }
  static var _taskBar = _bottomBarItem(Icons.list, '任务');
  static var _patientBar = _bottomBarItem(Icons.person_add, '患者');
  static var _clientBar = _bottomBarItem(Icons.contacts, '客户');
  static var _projectBar = _bottomBarItem(Icons.hotel, '中心');

  void _onChangePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  void initState(){
    _setPageList();
    super.initState();

  }

  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _setPageList() {
    List<Widget> _newRouteList = [Task(), Patient(), ClientAndVisiting(), Project()];
    List<BottomNavigationBarItem> _newBarList = [_taskBar, _patientBar, _clientBar, _projectBar];
    LocalStorageUtil.getListInfo('accessRight').then((accessRight) {
      if (accessRight.indexOf('task.find') == -1) {
        _newRouteList.remove(Task());
        _newBarList.remove(_taskBar);
      }
      if (accessRight.indexOf('trialSubject.find') == -1) {
        _newRouteList.remove(Patient());
        _newBarList.remove(_patientBar);
      }
      if (accessRight.indexOf('client.find') == -1) {
        _newRouteList.remove(ClientAndVisiting());
        _newBarList.remove(_clientBar);
      }
      if (accessRight.indexOf('site.findTrialSites') == -1) {
        _newRouteList.remove(Project());
        _newBarList.remove(_projectBar);
      }
      setState(() {
        _routeList = _newRouteList;
        _bottomNavigationBarList = _newBarList;
      });
    });
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
      body: PageView(
        controller: _homePageController,
        onPageChanged: _onChangePage,
        children: _routeList,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavigationBarList,
        currentIndex: _currentIndex,
        onTap: (int index) {
          _homePageController.jumpToPage(index);
        },
        selectedItemColor: Color(0xFF0DB0D4),
        unselectedItemColor: Color(0xFF75859E),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}