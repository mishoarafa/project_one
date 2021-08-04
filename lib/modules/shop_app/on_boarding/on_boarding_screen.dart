import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_one/modules/shop_app/login/login_screen.dart';
import 'package:project_one/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController boardController = PageController();

  List<OnBoardingModel> boardingList = [
    OnBoardingModel(
        "assets/images/onboard_1.png", "On Board 1 Title", "On Board 1 Body"),
    OnBoardingModel(
        "assets/images/onboard_1.png", "On Board 2 Title", "On Board 2 Body"),
    OnBoardingModel(
        "assets/images/onboard_1.png", "On Board 3 Title", "On Board 3 Body"),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Get.to(() => ShopLoginScreen());
            },
            child: Text(
              "Skip",
              style: TextStyle(
                color: defaultColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                physics: BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if (index == boardingList.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildOnBoardingItem(boardingList[index]),
                itemCount: boardingList.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boardingList.length,
                  effect: WormEffect(
                    activeDotColor: defaultColor,
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    (isLast)
                        ? Get.to(() => ShopLoginScreen())
                        : boardController.nextPage(
                            duration: Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardingItem(OnBoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              "${model.image}",
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "${model.title}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "${model.body}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
}

class OnBoardingModel {
  final String image;
  final String title;
  final String body;

  OnBoardingModel(this.image, this.title, this.body);
}
