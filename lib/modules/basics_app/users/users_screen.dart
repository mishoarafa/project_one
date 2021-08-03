import 'package:flutter/material.dart';
import 'package:project_one/models/user/user_model.dart';
import 'package:project_one/modules/basics_app/users/users_screen_widgets.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int itemCount = 1;
    List<UserModel> users = [
      UserModel(itemCount++, "Mohamed Medhat Arafa", "01069691929"),
      UserModel(itemCount++, "Omar Medhat Arafa", "01069691929"),
      UserModel(itemCount++, "Arafa", "01069691929"),
      UserModel(itemCount++, "Mohamed Arafa", "01069691929"),
      UserModel(itemCount++, "Ali Mohamed Ahmed", "01069691929"),
      UserModel(itemCount++, "Mohamed Medhat Arafa", "01069691929"),
      UserModel(itemCount++, "Omar Medhat Arafa", "01069691929"),
      UserModel(itemCount++, "Arafa", "01069691929"),
      UserModel(itemCount++, "Mohamed Arafa", "01069691929"),
      UserModel(itemCount++, "Ali Mohamed Ahmed", "01069691929")
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Users",
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => buildUserItem(users[index]),
        separatorBuilder: (context, index) => Container(
          margin: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          width: double.infinity,
          height: 1,
          color: Colors.grey[400],
        ),
        itemCount: users.length,
      ),
    );
  }
}
