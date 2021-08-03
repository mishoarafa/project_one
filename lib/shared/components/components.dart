import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_one/modules/news_app/web_view/web_view_screen.dart';
import 'package:project_one/shared/cubit/cubit.dart';

Widget defaultBtn({
  Color background = Colors.green,
  double width = double.infinity,
  required String text,
  required Function() function,
}) =>
    Container(
      width: width,
      color: background,
      child: MaterialButton(
        height: 50,
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
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
  Widget suffixIcon = const Text(""),
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
        border: OutlineInputBorder(),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon,
      ),
      validator: validate,
    );

Widget buildTaskItem(Map model, BuildContext context) =>
    Dismissible(
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

Widget myDivider() =>
    Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget buildArticleItem(context, article) =>
    InkWell(
      onTap: () {
        Get.to(() => WebViewScreen(article["url"]));
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
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1,
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
