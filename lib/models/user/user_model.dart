import 'package:flutter/material.dart';

class UserModel {
  @required final int id;
  @required final String name;
  @required final String phone;

  const UserModel(this.id, this.name, this.phone);
}