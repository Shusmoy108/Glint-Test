import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glinttest/controllers/userController.dart';
import 'package:glinttest/views/components/input/passwordinput.dart';
import 'package:glinttest/views/components/input/textinput.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenForm createState() => LoginScreenForm();
}

class LoginScreenForm extends State<LoginScreen> {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final UserController userController = Get.find();
  bool obsecure = false;
  void changeObsecure() {
    setState(() {
      obsecure = !obsecure;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Twitter",
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontFamily: "Lucidasans",
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            //height: 300,
            width: 350,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextInput("Email", emailController),
                PasswordInput(obsecure, passwordController, changeObsecure),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      onPressed: () async {
                        bool success =
                            await userController.signInWithEmailAndPassword(
                                emailController.text, passwordController.text);
                        if (success) {
                          emailController.clear();
                          passwordController.clear();
                        }
                      },
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Log In",
                            style: TextStyle(
                                fontFamily: "Lucidasans", fontSize: 20),
                          )),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.pink),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      onPressed: () async {
                        bool success =
                            await userController.signUpWithEmailAndPassword(
                                emailController.text, passwordController.text);
                        if (success) {
                          emailController.clear();
                          passwordController.clear();
                        }
                      },
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontFamily: "Lucidasans", fontSize: 20),
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ))),
                  onPressed: () async {
                    bool success = await userController.signInWithGoogle();
                    if (success) {
                      emailController.clear();
                      passwordController.clear();
                    }
                  },
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Sign In with Google",
                        style:
                            TextStyle(fontFamily: "Lucidasans", fontSize: 20),
                      )),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
                border: Border.all()),
          ),
        ),
      ),
    );
  }
}
