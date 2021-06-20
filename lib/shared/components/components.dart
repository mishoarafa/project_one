import 'package:flutter/material.dart';

Widget defaultBtn({
  Color background = Colors.green,
  double width = double.infinity,
  required String text,
  required Function() function,
}) => MaterialButton(
  minWidth: width,
  onPressed: function,
  color: background,
  child: Text(
    text,
    style: TextStyle(
      color: Colors.white,
    ),
  ),
);