import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/routes/home/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutterapp/utils/commonUtils.dart';
import 'package:flutterapp/api/common.dart';
import 'package:flutterapp/utils/common.dart';
import './loginApi.dart';
class Login extends StatefulWidget {
  @override
  Login({Key key}) : super(key: key);
  createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override

  void _onPush() {
    Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context) => Home()), (route) => route == null);
  }

  void showSimpleDialog() {
    showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: new Text('选择环境'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
          children: <Widget>[
            _chooseEnv('DEV'),
            _chooseEnv('TEST'),
            _chooseEnv('CLONE'),
            _chooseEnv('PRO'),
          ],
        );
      },
    );
  }

  Widget _chooseEnv(env) {
    return new SimpleDialogOption(
      child: new Text(env),
      onPressed: () {
        LocalStorageUtil.saveInfo('env', env)
        .then((onValue) {
          Global.init().then((e) {
            showToast('切换为$env');
            print(Global.env);
          });
        }).catchError((onError) {
          showToast('保存失败');
        });
        Navigator.pop(context);
      },
    );
  }

  void showToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0
    );
  }

  void _onSubmit() async{
    if (_userController.text.isEmpty || _passwordController.text.isEmpty) {
      showToast('手机号和密码不能为空');
      return null;
    }
    var dataInfo = {
      'phone': _userController.text,
      'password': _passwordController.text
    };
    var result = await LoginApi.userLogin(dataInfo);
    if (result != null && result['code'] == 'success') {
      _getConfig();
      _setAccessRight();
    }
  }

  void _getConfig() async {
    var result = await LoginApi.getConfig();
    if (result != null && result['code'] == 'success') {
      var configPayload = result['payload'] ?? {};
      Global.setConfig(configPayload);
    }
  }

  void _setAccessRight() async {
    var result = await LoginApi.getUserAccess();
    if (result != null && result['code'] == 'success') {
      List accessRightPayload = result['payload'] ?? [];
      List<String> accessRightList = [];
      for (var i = 0; i < accessRightPayload.length; i++) {
        accessRightList.add(accessRightPayload[i]);
      }
      await LocalStorageUtil.saveList('accessRight', accessRightList);
      _onPush();
    }
  }

  Widget backgroundImage(width, double height, String image){
    return new Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.fill
        )
      ),
    );
  }

  Widget inputItem(String label, Icon icon, bool obscureText, controller) {
    return new TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: label,
        errorText: null,
        prefixIcon: icon,
        filled: true,
        fillColor: Colors.white,
        border: InputBorder.none,
        focusedBorder: null,
      ),
    );
  }

  Widget loginForm() {
    return new Form(
      child: Container(
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 50.0,
              child: inputItem('手机号', Icon(Icons.person), false, _userController),
            ),
            Container(
              height: 50.0,
              child: inputItem('密码', Icon(Icons.lock), true, _passwordController),
            )
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/loginImages/login-background.png'),
            fit: BoxFit.fill
          )
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    backgroundImage(87.7, 207.7, 'images/loginImages/login-left-top.png'),
                    GestureDetector(
                      child: backgroundImage(92.6, 95.6, 'images/loginImages/login-right-top.png'),
                      onDoubleTap: () {
                        showSimpleDialog();
                      },
                    ),
                  ],
                ),
                backgroundImage(double.infinity, 247.4, 'images/loginImages/login-middle.png'),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    backgroundImage(86.9, 98.3, 'images/loginImages/login-left-buttom.png'),
                    backgroundImage(133.7, 116.6, 'images/loginImages/login-right-buttom.png'),
                  ],
                )
              ],
            ),
            Center(
              child: Container(
                width: 242.3,
                height: 450.1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Image.asset('images/loginImages/logo.png', width: 62.5, height: 37.8,),
                    loginForm(),
                    Container(
                      width: double.infinity,
                      child: RaisedButton(
                        child: Text('登陆'),
                        onPressed: () {
                          _onSubmit();
                        },
                        textColor: Colors.white,
                        color: Colors.blue,
                      ),
                    ),
                    Text('忘记密码?'),
                    Text('版本号: 3.0')
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}