import 'package:flutter/material.dart';
import 'package:project_one/shared/cubit/cubit.dart';

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

Widget defaultFormField({
  required TextEditingController controller,
  required String text,
  required IconData prefixIcon,
  TextInputType textInputType = TextInputType.text,
  bool isPassword = false,
  Function(String)? onSubmit,
  Function()? onTap,
  required String? Function(String?) validate,
  Widget suffixIcon = const Text(""),
}) =>
    TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: textInputType,
      onFieldSubmitted: onSubmit,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: text,
        border: OutlineInputBorder(),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon,
      ),
      validator: validate,
    );

Widget buildTaskItem(Map model, BuildContext context) => Dismissible(
      key: Key(model["id"].toString()),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(
                "${model["time"]}",
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${model["title"]}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${model["date"]}",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateDatabase(
                  status: "done",
                  id: model["id"],
                );
              },
              icon: Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateDatabase(
                  status: "archived",
                  id: model["id"],
                );
              },
              icon: Icon(
                Icons.archive,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteFromDB(id: model["id"]);
      },
    );
