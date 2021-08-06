import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:glinttest/controllers/userController.dart';
import 'package:glinttest/views/screens/login/loginpage.dart';
import 'package:glinttest/views/screens/home/homepage.dart';

class App extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Glint Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Obx(
          () => userController.login.value == true ? Home() : LoginScreen()),
    );
  }
}
