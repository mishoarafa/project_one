import 'package:flutter/material.dart';
import '../../app_bar_widgets.dart';
import 'messenger_screen_widgets.dart';

class MessengerScreenWithListViewBuilder extends StatelessWidget {
  const MessengerScreenWithListViewBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarMessengerScreen(),
      body: Padding(
        padding: const EdgeInsetsDirectional.only(
          top: 5,
        ),
        child: SingleChildScrollView(
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
              Container(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildStoryItem(),
                  itemCount: 15,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => buildChatItem(),
                separatorBuilder: (context, index) => SizedBox(
                  height: 15,
                ),
                itemCount: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
