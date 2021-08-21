import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one/models/shop_app/login_model.dart';
import 'package:project_one/modules/shop_app/login/cubit/states.dart';
import 'package:project_one/shared/network/end_points.dart';
import 'package:project_one/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  bool isPasswordShown = false;
  IconData suffixIcon = Icons.visibility_off_outlined;
  late ShopLoginModel loginModel;

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data: {
        "email": email,
        "password": password,
      },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      print("*************** After Login: " + value.data.toString());
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      print("********** Login Error: " + error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  void changeLoginPasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffixIcon = (isPasswordShown)? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(ShopLoginChangePasswordVisibilityState());
  }
}
