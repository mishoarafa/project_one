import 'package:flutter/material.dart';

PreferredSizeWidget appBarMessengerScreen() => AppBar(
  titleSpacing: 20,
  backgroundColor: Colors.white,
  elevation: 0,
  title: Row(
    children: [
      CircleAvatar(
        radius: 17,
        backgroundImage: NetworkImage(
            "https://www.wallpaperflare.com/static/594/468/54/nature-flowers-dark-background-purple-wallpaper.jpg"),
      ),
      SizedBox(
        width: 15,
      ),
      Text(
        "Chats",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ],
  ),
  actions: [
    IconButton(
      onPressed: () {},
      icon: CircleAvatar(
        radius: 15,
        backgroundColor: Colors.blue.withOpacity(0.8),
        child: Icon(
          Icons.camera_alt,
          size: 19,
          color: Colors.white,
        ),
      ),
    ),
    IconButton(
      onPressed: () {},
      icon: CircleAvatar(
        radius: 15,
        backgroundColor: Colors.blue.withOpacity(0.8),
        child: Icon(
          Icons.edit,
          size: 19,
          color: Colors.white,
        ),
      ),
    ),
  ],
);