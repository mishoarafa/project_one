import 'package:flutter/material.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  "https://www.elmostaqbal.com/elmostaqbal/uploads/2021/07/www.elmostaqbal.com_2021-07-23_02-02-07_071108.jpg"),
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Text(
              "Title",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "2021-08-01T09:56:10Z",
              style: TextStyle(
                color: Colors.grey,

              ),
            ),
          ],
        )
      ],
    );
  }
}
