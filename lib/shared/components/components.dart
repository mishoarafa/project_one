import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:project_one/layout/todo_app/cubit/cubit.dart';
import 'package:project_one/modules/news_app/web_view/web_view_screen.dart';
import 'package:project_one/modules/shop_app/login/shop_login_screen.dart';
import 'package:project_one/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:project_one/layout/todo_app/cubit/cubit.dart';
import 'package:project_one/modules/news_app/web_view/web_view_screen.dart';
import 'package:project_one/modules/shop_app/login/shop_login_screen.dart';
import 'package:project_one/shared/network/local/cache_helper.dart';

Widget defaultBtn({
  Color background = Colors.green,
  double width = double.infinity,
  required String text,
  required Function() function,
  bool isUpperCase = false,
  FontWeight btnTextWeight = FontWeight.normal,
  double btnTextSize = 14,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: background,
      ),
      child: MaterialButton(
        height: 50,
        onPressed: function,
        child: Text(
          (isUpperCase) ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: btnTextWeight,
            fontSize: btnTextSize,
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
  Function(String)? onChanged,
  required String? Function(String?) validate,
  IconData? suffixIcon,
  Function()? onSuffixPressed,
  FontWeight? textWeight = FontWeight.normal,
}) =>
    TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: textInputType,
      onFieldSubmitted: onSubmit,
      onTap: onTap,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: text,
        labelStyle: TextStyle(
          fontWeight: textWeight,
        ),
        border: OutlineInputBorder(),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: IconButton(
          onPressed: onSuffixPressed,
          icon: Icon(suffixIcon),
        ),
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

Widget myDivider() => Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget buildArticleItem(context, article) => InkWell(
      onTap: () {
        Get.to(
            () => WebViewScreen(article["url"], article["title"].toString()));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 120,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: (article["urlToImage"] != null)
                  ? Image.network(
                      "${article["urlToImage"]}",
                      fit: BoxFit.cover,
                    )
                  : Center(
                      child: Text(
                      "No image",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${article["title"]}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    "${article["publishedAt"]}",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

Widget defaultTextButton({
  required String text,
  required Function() onPressed,
  Color textColor = Colors.black,
  FontWeight? textWeight = FontWeight.normal,
  bool isUpperCase = false,
  double fontSize = 14,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        (isUpperCase) ? text.toUpperCase() : text,
        style: TextStyle(
          color: textColor,
          fontWeight: textWeight,
          fontSize: fontSize,
        ),
      ),
    );

void showToast({required String message, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

//enum (لما يكون عندك كذا اختيار بين اكتر من حاجة)
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      // TODO: Handle this case.
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      // TODO: Handle this case.
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      // TODO: Handle this case.
      color = Colors.amber;
      break;
  }

  return color;
}
