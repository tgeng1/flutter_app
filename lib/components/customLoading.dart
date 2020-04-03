import 'package:flutter/material.dart';

class CustomLoading extends Dialog {
  final String text;
  const CustomLoading({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Material(
        type: MaterialType.transparency,
        child: Center(
          child: SizedBox(
            width: 120.0,
            height: 120.0,
            child: Container(
              decoration: ShapeDecoration(
                color: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(text),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}