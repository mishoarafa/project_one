import 'package:flutter/material.dart';
import 'package:project_one/models/user/user_model.dart';

Widget buildUserItem(UserModel userModel) => Padding(
  padding: const EdgeInsets.all(20),
  child: Row(
    children: [
      CircleAvatar(
        radius: 25,
        child: Text(
          "${userModel.id}",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
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
              "${userModel.name}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${userModel.phone}",
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    ],
  ),
);