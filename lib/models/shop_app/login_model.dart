class ShopLoginModel {
  bool? status;
  String? message;
  UserData? data = UserData();

  ShopLoginModel();

  //named Constructor
  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = (json["data"]!= null)? UserData.fromJson(json["data"]) : null;
  }
}

class UserData {
  int? id;
  late String name;
  late String email;
  late String phone;
  late String image;
  int? points;
  int? credit;
  late String token;

  UserData();

  //named Constructor
  UserData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    image = json["image"];
    points = json["points"];
    credit = json["credit"];
    token = json["token"];
  }
}