import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final text;
  final pressed;
  final double width;
  final double height;
  final Color textColor;
  final Color color;
  const CustomButton({Key key, @required this.text, @required this.pressed, this.width, this.height, this.textColor, this.color}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      width: this.width,
      child: RaisedButton(
        child: Text(this.text),
        onPressed: this.pressed,
        textColor: this.textColor,
        color: this.color
      ),
    );
  }
}