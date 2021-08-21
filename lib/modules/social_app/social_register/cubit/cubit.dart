import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one/modules/social_app/social_register/cubit/states.dart';
import 'package:project_one/shared/network/end_points.dart';
import 'package:project_one/shared/network/remote/dio_helper.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  bool isPasswordShown = false;
  IconData suffixIcon = Icons.visibility_off_outlined;

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  // void userRegister({
  //   required String email,
  //   required String password,
  //   required String name,
  //   required String phone,
  // }) {
  //   emit(SocialRegisterLoadingState());
  //
  //   DioHelper.postData(
  //     url: REGISTER,
  //     data: {
  //       "email": email,
  //       "name": name,
  //       "phone": phone,
  //       "password": password,
  //     },
  //   ).then((value) {
  //     loginModel = SocialLoginModel.fromJson(value.data);
  //     print("*************** After Register: " + value.data.toString());
  //     emit(SocialRegisterSuccessState(loginModel));
  //   }).catchError((error) {
  //     print("********** Register Error: " + error.toString());
  //     emit(SocialRegisterErrorState(error.toString()));
  //   });
  // }

  void changeRegisterPasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffixIcon = (isPasswordShown)? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
