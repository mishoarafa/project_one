import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one/modules/social_app/social_login/cubit/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  bool isPasswordShown = false;
  IconData suffixIcon = Icons.visibility_off_outlined;

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      print("******* User Email: " + value.user!.email.toString());
      print("******* UID: " + value.user!.uid.toString());
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  void changeLoginPasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffixIcon = (isPasswordShown)
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;

    emit(SocialLoginChangePasswordVisibilityState());
  }
}
