import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one/modules/social_app/social_login/cubit/states.dart';
import 'package:project_one/shared/network/end_points.dart';
import 'package:project_one/shared/network/remote/dio_helper.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  bool isPasswordShown = false;
  IconData suffixIcon = Icons.visibility_off_outlined;

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  // void userLogin({
  //   required String email,
  //   required String password,
  // }) {
  //   emit(SocialLoginLoadingState());
  //
  //   DioHelper.postData(
  //     url: LOGIN,
  //     data: {
  //       "email": email,
  //       "password": password,
  //     },
  //   ).then((value) {
  //     loginModel = SocialLoginModel.fromJson(value.data);
  //     print("*************** After Login: " + value.data.toString());
  //     emit(SocialLoginSuccessState(loginModel));
  //   }).catchError((error) {
  //     print("********** Login Error: " + error.toString());
  //     emit(SocialLoginErrorState(error.toString()));
  //   });
  // }

  void changeLoginPasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffixIcon = (isPasswordShown)? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(SocialLoginChangePasswordVisibilityState());
  }
}
