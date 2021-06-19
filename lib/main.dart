import 'package:flutter/material.dart';
import 'package:project_one/modules/home/home_screen.dart';
import 'package:project_one/modules/messenger/messenger_screen.dart';
import 'package:project_one/modules/users/users_screen.dart';
import 'modules/bmi_result/bmi_result_screen.dart';
import 'modules/messenger/messenger_screen_with_listview_builder.dart';
import 'modules/bmi/bmi_calculator_screen.dart';
import 'modules/counter/counter_screen.dart';
import 'modules/login/login_screen.dart';

void main() {
  runApp(MyApp());
}

//class MyApp
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }

}