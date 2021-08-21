import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_one/layout/shop_app/cubit/cubit.dart';
import 'package:project_one/layout/shop_app/cubit/states.dart';
import 'package:project_one/shared/components/components.dart';
import 'package:project_one/shared/components/constants.dart';
import 'package:project_one/shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {
        if (state is ShopUserProfileDataSuccessState) {
          // nameController.text = state.loginModel.data!.name;
          // emailController.text = state.loginModel.data!.email;
          // phoneController.text = state.loginModel.data!.phone;
        }
      },
      builder: (BuildContext context, state) {
        var cubit = ShopCubit.get(context);
        var model = cubit.userModel;

        nameController.text = model.data!.name;
        emailController.text = model.data!.email;
        phoneController.text = model.data!.phone;

        if (cubit.userModel != null) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsetsDirectional.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopUpdateUserLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                      controller: nameController,
                      text: "Full Name",
                      prefixIcon: Icons.person,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Name must not be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    defaultFormField(
                      controller: emailController,
                      text: "Email Address",
                      textInputType: TextInputType.emailAddress,
                      prefixIcon: Icons.email,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Email Address must not be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      text: "Phone",
                      textInputType: TextInputType.number,
                      prefixIcon: Icons.phone,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "Phone must not be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    defaultBtn(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          cubit.updateUserProfileData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                      text: "Update",
                      btnTextWeight: FontWeight.bold,
                      background: defaultColor,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    defaultBtn(
                      function: () {
                        signOut();
                      },
                      text: "Logout",
                      btnTextWeight: FontWeight.bold,
                      background: defaultColor,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: SpinKitCircle(color: defaultColor),
          );
        }
      },
    );
  }
}
