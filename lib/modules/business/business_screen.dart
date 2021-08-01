import 'package:flutter/material.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          "https://cdni.rt.com/media/pics/2021.07/original/6105808c4c59b722741256db.JPG",
          width: 120,
          height: 120,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
