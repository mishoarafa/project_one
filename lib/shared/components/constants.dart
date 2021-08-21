import 'package:get/get.dart';
import 'package:project_one/modules/shop_app/login/shop_login_screen.dart';
import 'package:project_one/shared/network/local/cache_helper.dart';

void signOut() {
  CacheHelper.removeData(key: "token").then((value) {
    if (value) Get.offAll(() => ShopLoginScreen());
  });
}

void printFullText(text) {
  final pattern = RegExp(".{1,800}");   //800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = "";