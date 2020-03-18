import 'package:flutter/material.dart';
import 'package:flutterapp/app.dart';
import 'package:flutterapp/utils/common.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Global.init().then((e) => runApp(new App()));
}

