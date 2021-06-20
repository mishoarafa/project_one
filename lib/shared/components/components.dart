import 'package:flutter/material.dart';

Widget defaultBtn({
  Color background = Colors.green,
  double width = double.infinity,
  required String text,
  required Function() function,
}) =>
    Container(
      width: width,
      color: background,
      child: MaterialButton(
        height: 50,
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget authTextFormField({
  required TextEditingController controller,
  required String text,
  required IconData icon,
  TextInputType textInputTypeype = TextInputType.text,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: textInputTypeype,
      onFieldSubmitted: (value) {
        print(value);
      },
      decoration: InputDecoration(
        labelText: text,
        border: OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
    );
