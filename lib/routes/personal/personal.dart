import 'package:flutter/material.dart';
import 'package:flutterapp/utils/common.dart';
import 'package:flutterapp/routes/login/login.dart';
class Personal extends StatefulWidget {
  @override
  createState() => PersonalState();
}

class PersonalState extends State<Personal> {
  void resetPassword() {
    print('resetPassword');
  }

  void clearData() {
    print('clear');
  }

  Future signOut() async{
    await Global.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (route) => route == null
    );
  }

  Widget customBtn(text, onPressed) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: 50,
        padding: EdgeInsets.only(left: 10, right: 10),
        margin: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: Color.fromRGBO(132, 182, 255, 0.31),
          borderRadius: BorderRadius.all(Radius.circular(5.0))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(text, style: TextStyle(color: Colors.white),),
            Icon(Icons.chevron_right, color: Colors.white,)
          ],
        ),
      ),
      onTap: onPressed,
    );
  }
  Widget qRCode() {
    return Container(
      width: double.infinity,
      height: 300,
      padding: EdgeInsets.only(left: 10, right: 10),
      margin: EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: Color.fromRGBO(132, 182, 255, 0.31),
        borderRadius: BorderRadius.all(Radius.circular(5.0))
      ),
      child: Text(
        '二维码'
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            alignment:  Alignment(-1, -1),
            decoration: BoxDecoration(
              color: Color(0xFF4a90e2),
            ),
            child: Image(
              image: AssetImage('images/personalImages/selfsite-background.png'),
            ),
          ),
          Container(
            height: double.infinity,
            padding: EdgeInsets.all(20.0),
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // user name
                    Container(
                      margin: EdgeInsets.only(bottom: 20, top: 10),
                      child: Text(
                        '田庚',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // reset password
                    customBtn('修改密码', resetPassword),
                    customBtn('清除缓存', clearData),
                    qRCode(),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('left'),
                      GestureDetector(
                        child: Text(
                          '退出',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.white
                          ),
                        ),
                        onTap: signOut,
                      )
                    ],
                  ),
                )
              ],
            )
          )
        ],
      ),
    );
  }
}