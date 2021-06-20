import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_one/shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

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
                  textInputTypeype: TextInputType.emailAddress,
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
                  textInputTypeype: TextInputType.phone,
                ),
                SizedBox(
                  height: 20,
                ),
                defaultBtn(
                    text: "Register",
                    function: () {
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          )
                          .then((value) => () {
                            print("email: " + value.user!.email.toString());
                            print("UID" + value.user!.uid);
                      });
                      // print("Email: " + emailController.text);
                      // print("Password: " + passwordController.text);
                    }),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                      onPressed: () {},
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
