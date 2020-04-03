import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final List<dynamic> titleList;
  const CustomAppBar({Key key, @required this.titleList}) : super(key: key);

  List<Widget>_appBarTitle() {
    List<Widget> _list = [];
    titleList.map((item) {
      if (item['fnc'] != null) {
        Widget _titleItem = GestureDetector(
          onTap: item['fnc'],
          child: Text(item['title']),
        );
        _list.add(_titleItem);
      } else {
        Widget _titleItem = Text(item['title']);
        _list.add(_titleItem);
      }
    }).toList();
    return _list;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _appBarTitle(),
    );
  }
}