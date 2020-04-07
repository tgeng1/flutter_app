import 'package:flutter/material.dart';
import 'package:flutterapp/routes/personal/personal.dart';
class ClientAndVisiting extends StatefulWidget {
  @override
  _ClientAndVisitingState createState() => _ClientAndVisitingState();
}

class _ClientAndVisitingState extends State<ClientAndVisiting> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive =>true;
  void initState() {
    print('---client------->');
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('客户'),
            Container(width: 10),
            Text('拜访'),
          ],
        ),
        actions: <Widget>[
          Icon(Icons.insert_chart),
          Icon(Icons.message)
        ],
      ),
      drawer: Personal(),
      body: Center(child: Text('client'),),
    );
  }
}