import 'package:flutter/material.dart';
import 'package:flutterapp/utils/common.dart';
import 'package:flutterapp/utils/commonUtils.dart';
import 'package:flutterapp/routes/login/login.dart';
import './personalApi.dart';
class Personal extends StatefulWidget {
  const Personal({Key key}) : super(key: key);
  @override
  _PersonalState createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  static Map<String, dynamic> _userInfo;
  static String _userName;
  void initState() {
    super.initState();
  }
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getUserInfo();
  }

  Future _getUserInfo() async{
    String _userId = await LocalStorageUtil.getInfo('userId');
    if (_userId.isNotEmpty) {
      Map<String, dynamic> _result = await PersonalApi.getUserInf(_userId);
      if (_result.isNotEmpty && _result['code'] == 'success') {
        Map<String, dynamic> _userInfoResult = _result['payload'];
        setState(() {
          _userInfo = _userInfoResult;
          _userName = _userInfoResult['name'];
        });
      }
    }

  }
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
    print('---------data---->$_userInfo');
    print('----------name---->$_userName');
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
                        _userName ?? '',
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