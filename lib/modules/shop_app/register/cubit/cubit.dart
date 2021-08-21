import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one/models/shop_app/login_model.dart';
import 'package:project_one/modules/shop_app/register/cubit/states.dart';
import 'package:project_one/shared/network/end_points.dart';
import 'package:project_one/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  bool isPasswordShown = false;
  IconData suffixIcon = Icons.visibility_off_outlined;
  late ShopLoginModel loginModel;

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(
      url: REGISTER,
      data: {
        "email": email,
        "name": name,
        "phone": phone,
        "password": password,
      },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      print("*************** After Register: " + value.data.toString());
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error) {
      print("********** Register Error: " + error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  void changeRegisterPasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffixIcon = (isPasswordShown)? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(ShopRegisterChangePasswordVisibilityState());
  }
}
