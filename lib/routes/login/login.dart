import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/routes/home/home.dart';
import 'package:flutterapp/utils/commonUtils.dart';
import 'package:flutterapp/utils/common.dart';
import './loginApi.dart';
import 'package:flutterapp/components/customButton.dart';
class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _showSimpleDialog() {
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
      return Home();
    }));
  }

  Future _onSubmit() async{
    if (_userController.text.isEmpty || _passwordController.text.isEmpty) {
      Global.showToast('手机号和密码不能为空');
      return null;
    }
    FocusScope.of(context).requestFocus(FocusNode());
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
      }
    }
  }

  Future _getConfig() async {
    var result = await LoginApi.getConfig();
    if (result != null && result['code'] == 'success') {
      _setAccessRight();
      var configPayload = result['payload'] ?? {};
      await Global.setConfig(configPayload);
    }
  }

  Future _setAccessRight() async {
    var result = await LoginApi.getUserAccess();
    if (result != null && result['code'] == 'success') {
      List accessRightPayload = result['payload'] ?? [];
      List<String> accessRightList = [];
      accessRightPayload.map((item) => accessRightList.add(item)).toList();
      await Global.setAccessRight(accessRightList);
      await _onPush();
    }
  }

  Widget _backgroundImage(width, double height, String image){
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

  Widget _inputItem(String label, Icon icon, bool obscureText, controller) {
    return new TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: TextInputType.number,
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

  Widget _loginForm() {
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
              child: _inputItem('手机号', Icon(Icons.person), false, _userController),
            ),
            Container(
              height: 50.0,
              child: _inputItem('密码', Icon(Icons.lock), true, _passwordController),
            )
          ],
        ),
      ),
    );
  }

  Widget _loginBackground() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _backgroundImage(87.7, 207.7, 'images/loginImages/login-left-top.png'),
            GestureDetector(
              child: _backgroundImage(92.6, 95.6, 'images/loginImages/login-right-top.png'),
              onDoubleTap: () {
                _showSimpleDialog();
              },
            ),
          ],
        ),
        _backgroundImage(double.infinity, 247.4, 'images/loginImages/login-middle.png'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _backgroundImage(86.9, 98.3, 'images/loginImages/login-left-buttom.png'),
            _backgroundImage(133.7, 116.6, 'images/loginImages/login-right-buttom.png'),
          ],
        )
      ],
    );
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/loginImages/login-background.png'),
              fit: BoxFit.fill
            )
          ),
          child: Stack(
            children: <Widget>[
              _loginBackground(),
              Center(
                child: Container(
                  width: 242.3,
                  height: 450.1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset('images/loginImages/logo.png', width: 62.5, height: 37.8,),
                      _loginForm(),
                      CustomButton(text: '登陆', pressed: _onSubmit, width: double.infinity, textColor: Colors.white, color: Colors.blue,),
                      Text('忘记密码?'),
                      Text('版本号: 3.0')
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}