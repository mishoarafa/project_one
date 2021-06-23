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
  TextInputType textInputType = TextInputType.text,
  bool isPassword = false,
  Function(String)? onSubmit,
}) =>
    TextFormField(
      validator: (value){

      },

      controller: controller,
      obscureText: isPassword,
      keyboardType: textInputType,
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
          labelText: text,
          border: OutlineInputBorder(),
          prefixIcon: Icon(icon),
          suffixIcon: isPassword
              ? Visibility(
                  visible: true,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.remove_red_eye,
                    ),
                  ),
                )
              : Visibility(
                  visible: false,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.remove_red_eye,
                    ),
                  ),
                )),
    );
