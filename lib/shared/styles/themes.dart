import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_one/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: socialDefaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey[700],
    elevation: 20,
    backgroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    headline6: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  fontFamily: "Jannah",
);

ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Color(0xff333739),
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xff333739),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Color(0xff333739),
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.blue[200],
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    iconTheme: IconThemeData(
      color: Colors.blue[200],
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey[400],
    elevation: 20,
    backgroundColor: Color(0xff262728),
  ),
  textTheme: TextTheme(
    headline6: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  fontFamily: "Jannah",
);
