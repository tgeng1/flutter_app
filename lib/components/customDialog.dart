import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final title;
  final content;
  final onOkFnc;
  final onCancelFnc;
  const CustomDialog({Key key, @required this.title, @required this.content, @required this.onOkFnc, this.onCancelFnc}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        FlatButton(
          child: Text('取消'),
          onPressed: () {
            onCancelFnc();
          },
        ),
        FlatButton(
          child: Text('确定'),
          onPressed: () {
            onOkFnc();
          },
        )
      ],
    );
  }
}
