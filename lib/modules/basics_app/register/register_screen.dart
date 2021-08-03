import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_one/modules/basics_app/login/login_screen.dart';
import 'package:project_one/shared/components/components.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool showPassword = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    // void userCreate(uID) {
    //   FirebaseFirestore.instance.collection("users").doc(uID).set({
    //     "name" : nameController.text,
    //     "email" : emailController.text,
    //     "phone" : phoneController.text,
    //     "UID" : uID,
    //     "isEmailVerified" : false,
    //   }).then((value) {
    //     print("success!!");
    //     Get.offAll(BMIScreen());
    //   }).catchError((error){
    //     print(error.toString());
    //   });
    // };

    // void userRegister() {
    //   FirebaseAuth.instance
    //       .createUserWithEmailAndPassword(
    //     email: emailController.text,
    //     password: passwordController.text,
    //   )
    //       .then((value) {
    //     print("email: " + value.user!.email.toString());
    //     print("UID: " + value.user!.uid);
    //     userCreate(value.user!.uid);
    //   }).catchError((error) {
    //     print(error);
    //   });
    // };

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  defaultFormField(
                    controller: nameController,
                    text: "Full Name",
                    prefixIcon: Icons.person,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "Name must not be empty";
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
                    prefixIcon: Icons.email,
                    textInputType: TextInputType.emailAddress,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "Email Address must not be empty";
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
                    isPassword: !showPassword,
                    prefixIcon: Icons.lock,
                    textInputType: TextInputType.visiblePassword,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "Password must not be empty";
                      }
                      return null;
                    },
                    suffixIcon: showPassword
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                                print(showPassword);
                              });
                            },
                            icon: Icon(
                              Icons.visibility,
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                                print(showPassword);
                              });
                            },
                            icon: Icon(
                              Icons.visibility_off,
                            ),
                          ),
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    text: "Phone",
                    prefixIcon: Icons.phone,
                    textInputType: TextInputType.phone,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "Phone must not be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.green,
                    child: MaterialButton(
                      height: 50,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          print("Register Done!!!");
                        }
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Get.offAll(LoginScreen());
                        },
                        child: Text(
                          "Sign in",
                        ),
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
  }
}
