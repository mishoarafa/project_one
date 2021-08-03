import 'package:flutter/material.dart';

Widget buildStoryItem() => Row(
      children: [
        SizedBox(
          width: 15,
        ),
        Container(
          width: 65,
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        "https://www.wallpaperflare.com/static/594/468/54/nature-flowers-dark-background-purple-wallpaper.jpg"),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      bottom: 2,
                      end: 2,
                    ),
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 6,
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Mohamed Medhat Mohamed Arafa",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );

Widget buildChatItem() => Container(
      margin: EdgeInsetsDirectional.only(
        end: 10,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsetsDirectional.only(
              start: 15,
              top: 10,
            ),
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      "https://www.wallpaperflare.com/static/594/468/54/nature-flowers-dark-background-purple-wallpaper.jpg"),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    bottom: 2,
                    end: 2,
                  ),
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 6,
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mohamed Medhat Mohamed Arafaaaaa",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 9,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "It's my Message!! Welcome ✋🏻 to community",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: CircleAvatar(
                        radius: 3,
                        backgroundColor: Colors.blue,
                      ),
                    ),
                    Text(
                      "02:00 pm",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
