import 'package:flutter/material.dart';

class CustomLoading extends Dialog {
  final String text;
  const CustomLoading({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromRGBO(245, 245, 245, 0.5),
      ),
      child: Center(
        child: Container(
          width: 120.0,
          height: 120.0,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircularProgressIndicator(),
              Text(text)
            ],
          ),
        ),
      ),
    );
  }
}