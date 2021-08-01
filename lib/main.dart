import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:project_one/layout/todo_app/todo_layout.dart';
import 'package:project_one/modules/home/home_screen.dart';
import 'package:project_one/modules/messenger/messenger_screen.dart';
import 'package:project_one/modules/users/users_screen.dart';
import 'package:project_one/shared/bloc_observer.dart';
import 'package:project_one/shared/network/remote/dio_helper.dart';
import 'layout/new_app/news_layout.dart';
import 'modules/bmi_result/bmi_result_screen.dart';
import 'modules/messenger/messenger_screen_with_listview_builder.dart';
import 'modules/bmi/bmi_calculator_screen.dart';
import 'modules/counter/counter_screen.dart';
import 'modules/login/login_screen.dart';
import 'modules/register/register_screen.dart';

void main(){
  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  runApp(MyApp());
}

//class MyApp
class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {

      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {

      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.blue[900],
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          iconTheme: IconThemeData(
            color: Colors.blue[900],
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepOrange,
          elevation: 20,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.deepOrange,
        ),
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black26,
      ),
      themeMode: ThemeMode.light,
      home: NewsLayout(),
    );
  }
}