import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_one/modules/bmi/bmi_calculator_screen.dart';
import 'package:project_one/modules/login/login_screen.dart';
import 'package:project_one/shared/components/components.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();


    void userCreate(uID) {
      FirebaseFirestore.instance.collection("users").doc(uID).set({
        "name" : nameController.text,
        "email" : emailController.text,
        "phone" : phoneController.text,
        "UID" : uID,
        "isEmailVerified" : false,
      }).then((value) {
        print("success!!");
        Get.offAll(BMIScreen());
      }).catchError((error){
        print(error.toString());
      });
    };

    void userRegister() {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((value) {
        print("email: " + value.user!.email.toString());
        print("UID: " + value.user!.uid);
        userCreate(value.user!.uid);
      }).catchError((error) {
        print(error);
      });
    };

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
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
                authTextFormField(
                  controller: nameController,
                  text: "Full Name",
                  icon: Icons.person,
                ),
                SizedBox(
                  height: 15,
                ),
                authTextFormField(
                  controller: emailController,
                  text: "Email Address",
                  icon: Icons.email,
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  onFieldSubmitted: (value) {
                    print(value);
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
                SizedBox(
                  height: 15,
                ),
                authTextFormField(
                  controller: phoneController,
                  text: "Phone",
                  icon: Icons.phone,
                  textInputType: TextInputType.phone,
                ),
                SizedBox(
                  height: 20,
                ),

                Container(
                  width: double.infinity,
                  color: Colors.green,
                  child: MaterialButton(
                    height: 50,
                    onPressed: userRegister,
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
    );
  }
}
