import 'package:flutter/material.dart';
import '../../app_bar_widgets.dart';
import 'messenger_screen_widgets.dart';

class MessengerScreen extends StatelessWidget {
  const MessengerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarMessengerScreen(),
      body: Padding(
        padding: const EdgeInsetsDirectional.only(
          top: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsetsDirectional.fromSTEB(7, 0, 7, 7),
              padding: EdgeInsetsDirectional.fromSTEB(13, 5, 5, 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
              child: Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Search",
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: buildStoryItem(),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    buildChatItem(),
                    SizedBox(
                      height: 10,
                    ),
                    buildChatItem(),
                    SizedBox(
                      height: 10,
                    ),
                    buildChatItem(),
                    SizedBox(
                      height: 10,
                    ),
                    buildChatItem(),
                    SizedBox(
                      height: 10,
                    ),
                    buildChatItem(),
                    SizedBox(
                      height: 10,
                    ),
                    buildChatItem(),
                    SizedBox(
                      height: 10,
                    ),
                    buildChatItem(),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
