import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:project_one/modules/social_app/social_login/cubit/cubit.dart';
import 'package:project_one/modules/social_app/social_login/cubit/states.dart';
import 'package:project_one/modules/social_app/social_register/social_register_screen.dart';
import 'package:project_one/shared/components/components.dart';
import 'package:project_one/shared/styles/colors.dart';

class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          var cubit = SocialLoginCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Login",
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Login now to communicate with friends",
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: emailController,
                          text: "Email Address",
                          textWeight: FontWeight.bold,
                          textInputType: TextInputType.emailAddress,
                          prefixIcon: Icons.email_outlined,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Please, Enter your Email Address";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          text: "Password",
                          textWeight: FontWeight.bold,
                          textInputType: TextInputType.visiblePassword,
                          isPassword: !cubit.isPasswordShown,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              // cubit.userLogin(
                              //     email: emailController.text,
                              //     password: passwordController.text);
                            }
                          },
                          suffixIcon: cubit.suffixIcon,
                          onSuffixPressed: () {
                            cubit.changeLoginPasswordVisibility();
                          },
                          prefixIcon: Icons.lock_outline,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Please, Enter your Password";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        (state is! SocialLoginLoadingState)
                            ? defaultBtn(
                          text: "Login",
                          background: defaultColor,
                          isUpperCase: true,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              // cubit.userLogin(
                              //     email: emailController.text,
                              //     password: passwordController.text);
                            }
                          },
                          btnTextWeight: FontWeight.bold,
                        )
                            : Center(
                          child: SpinKitFadingCircle(color: defaultColor),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                            ),
                            defaultTextButton(
                              onPressed: () {
                                Get.to(() => SocialRegisterScreen());
                              },
                              text: "Register Now",
                              textColor: defaultColor,
                              textWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}