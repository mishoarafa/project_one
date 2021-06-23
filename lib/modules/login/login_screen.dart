import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_one/modules/register/register_screen.dart';
import 'package:project_one/shared/components/components.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    var emailFormKey = GlobalKey<FormState>();
    var passwordFormKey = GlobalKey<FormState>();

    void userSignIn() {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((value) {
        print("Email: " + value.user!.email.toString());
        print("UID: " + value.user!.uid);
      }).catchError((error){
        print(error);
      });
    };

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
                // mainAxisAlignment: MainAxisAlignment.center,
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


                  Form(
                    key: emailFormKey,
                    child: TextFormField(
                      validator: (value){
                        if (value!.isEmpty){
                          return "Email Address must not be empty";
                        }
                        return null;
                      },
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (value) {
                        if(emailFormKey.currentState!.validate()){
                          print(value);
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Email Address",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.email,
                        ),
                      ),
                    ),
                  ),

                  // authTextFormField(
                  //   controller: emailController,
                  //   textInputType: TextInputType.emailAddress,
                  //   text: "Email Address",
                  //   icon: Icons.email,
                  // ),


                  SizedBox(
                    height: 15,
                  ),

                  // authTextFormField(
                  //   controller: passwordController,
                  //   textInputType: TextInputType.visiblePassword,
                  //   text: "Password",
                  //   icon: Icons.lock,
                  //   isPassword: true,
                  // ),

                  Form(
                    key: passwordFormKey,
                    child: TextFormField(
                      validator: (value){
                        if (value!.isEmpty){
                          return "You must enter Password";
                        }
                        return null;
                      },
                      controller: passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      onFieldSubmitted: (value) {
                        if(passwordFormKey.currentState!.validate()){
                          print(value);
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.remove_red_eye,
                          ),
                        ),
                      ),
                    ),
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
                    function: (){
                      if (formKey.currentState!.validate()){
                        userSignIn();
                      }
                    }
                  ),


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
