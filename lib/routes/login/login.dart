import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/routes/home/home.dart';
import 'package:flutterapp/utils/commonUtils.dart';
import 'package:flutterapp/utils/common.dart';
import './loginApi.dart';
import 'package:flutterapp/components/customButton.dart';
class Login extends StatefulWidget {
  @override
  Login({Key key}) : super(key: key);
  createState() => LoginState();
}

class LoginState extends State<Login> {
  static List routeList = [];

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void showSimpleDialog() {
    List<Widget> list = [
      _chooseEnv('DEV'),
      _chooseEnv('TEST'),
      _chooseEnv('CLONE'),
      _chooseEnv('PRO')
    ];
    showDialog<Null>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('选择环境'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
          children: list,
        );
      }
    );
  }

  Widget _chooseEnv(env) {
    return new SimpleDialogOption(
      child: new Text(env),
      onPressed: () {
        LocalStorageUtil.saveInfo('env', env)
        .then((onValue) {
          Global.init().then((e) {
            Global.showToast('切换为$env');
          });
        }).catchError((onError) {
          Global.showToast('保存失败');
        });
        Navigator.pop(context);
      },
    );
  }

  Future _onPush() async{
    await Navigator.push(context, new MaterialPageRoute(builder: (context) {
      return Home(routeList: routeList);
    }));
  }

  Future _onSubmit() async{
    if (_userController.text.isEmpty || _passwordController.text.isEmpty) {
      Global.showToast('手机号和密码不能为空');
      return null;
    }
    var dataInfo = {
      'phone': _userController.text,
      'password': _passwordController.text
    };
    var result = await LoginApi.userLogin(dataInfo);
    print(result);
    if (result != null && result['code'] == 'success') {
      var updateUserInfo = await Global.updateUserData(result['payload']['token'], result['payload']['_id']);
      if (updateUserInfo == true) {
        _getConfig();
        _setAccessRight();
      }
    }
  }

  Future _getConfig() async {
    var result = await LoginApi.getConfig();
    if (result != null && result['code'] == 'success') {
      var configPayload = result['payload'] ?? {};
      await Global.setConfig(configPayload);
    }
  }

  Future _setAccessRight() async {
    var result = await LoginApi.getUserAccess();
    if (result != null && result['code'] == 'success') {
      List accessRightPayload = result['payload'] ?? [];
      List<String> accessRightList = [];
      for (var i = 0; i < accessRightPayload.length; i++) {
        accessRightList.add(accessRightPayload[i]);
      }
      await LocalStorageUtil.saveList('accessRight', accessRightList);
      await _onPush();
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

  Widget loginBackground() {
    return Column(
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
            loginBackground(),
            Center(
              child: Container(
                width: 242.3,
                height: 450.1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Image.asset('images/loginImages/logo.png', width: 62.5, height: 37.8,),
                    loginForm(),
                    CustomButton(text: '登陆', pressed: _onSubmit, width: double.infinity, textColor: Colors.white, color: Colors.blue,),
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