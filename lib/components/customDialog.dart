import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final text;
  final list;
  const CustomDialog({Key key, @required this.text, @required this.list}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(text),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
      children: list,
    );
  }
}
