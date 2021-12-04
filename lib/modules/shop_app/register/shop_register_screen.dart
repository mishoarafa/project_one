import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:project_one/layout/shop_app/shop_layout.dart';
import 'package:project_one/modules/shop_app/register/cubit/cubit.dart';
import 'package:project_one/modules/shop_app/register/cubit/states.dart';
import 'package:project_one/shared/components/components.dart';
import 'package:project_one/shared/components/constants.dart';
import 'package:project_one/shared/network/local/cache_helper.dart';
import 'package:project_one/shared/styles/colors.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (BuildContext context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status!) {
              print("*********** Message: " + state.loginModel.message!);
              print("*********** Token: " + state.loginModel.data!.token);
              CacheHelper.saveData(
                key: "token",
                value: state.loginModel.data!.token,
              ).then((value) {
                token = state.loginModel.data!.token;
                Get.offAll(() => ShopLayout());
                showToast(
                  message: state.loginModel.message!,
                  state: ToastStates.SUCCESS,
                );
              });
            } else {
              //It will print only the message because the token is null
              print("******** Message: " + state.loginModel.message!);
              showToast(
                message: state.loginModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (BuildContext context, state) {
          var cubit = ShopRegisterCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Register",
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
                          "REGISTER",
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          "Register to browse our hot offers",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: nameController,
                          text: "Full Name",
                          textWeight: FontWeight.bold,
                          prefixIcon: Icons.person,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Please, Enter your Name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
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
                          onSubmit: (value) {},
                          suffixIcon: cubit.suffixIcon,
                          onSuffixPressed: () {
                            cubit.changeRegisterPasswordVisibility();
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
                          height: 15,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          text: "Phone Number",
                          textWeight: FontWeight.bold,
                          textInputType: TextInputType.phone,
                          prefixIcon: Icons.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Please, Enter your Phone Number";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        (state is! ShopRegisterLoadingState)
                            ? defaultBtn(
                                text: "Register",
                                background: defaultColor,
                                btnTextWeight: FontWeight.bold,
                                isUpperCase: true,
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userRegister(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                              )
                            : Center(
                                child: SpinKitFadingCircle(color: defaultColor),
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
