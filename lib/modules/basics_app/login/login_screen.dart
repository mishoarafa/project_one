import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_one/modules/basics_app/register/register_screen.dart';
import 'package:project_one/shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var emailFormKey = GlobalKey<FormState>();
  var passwordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // void userSignIn() {
    //   FirebaseAuth.instance
    //       .signInWithEmailAndPassword(
    //     email: emailController.text,
    //     password: passwordController.text,
    //   )
    //       .then((value) {
    //     print("Email: " + value.user!.email.toString());
    //     print("UID: " + value.user!.uid);
    //   }).catchError((error){
    //     print("ERROR ************** " + error.toString());
    //   });
    // };

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),

                  defaultFormField(
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                    text: "Email Address",
                    prefixIcon: Icons.email,
                    validate: (value) {
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
                    textInputType: TextInputType.visiblePassword,
                    text: "Password",
                    prefixIcon: Icons.lock,
                    isPassword: !showPassword,
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
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "Password must not be empty";
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  //TODO: button before validation
                  // defaultBtn(
                  //     text: "Login",
                  //     function: userSignIn,
                  // ),

                  //TODO: button after validation
                  defaultBtn(
                      text: "Login",
                      function: () {
                        if (formKey.currentState!.validate()) {
                          //userSignIn
                          print("Welcome ${emailController.text}");
                        }
                      }),

                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Get.to(RegisterScreen());
                        },
                        child: Text(
                          "Register Now",
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
