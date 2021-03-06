import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class UserController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  var login = false.obs;
  User? user;
  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  fetchUser() {
    auth.userChanges().listen((event) {
      if (event != null) {
        user = event;
        login.value = true;
      } else {
        login.value = false;
      }
    });
  }

  Future<void> signOut() async {
    await auth.signOut();
    login.value = false;
  }

  logIn(String mobile, String password) {}

  signUp(String name, String mobile, String password) {}
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      final User? user = (await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      login.value = true;
      Get.snackbar("Success", "${user!.email} signed in successfully",
          backgroundColor: Colors.green, colorText: Colors.white);
      return true;
    } catch (e) {
      Get.snackbar("Error", "Failed to log in because $e",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
  }

  Future<bool> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;

      login.value = true;
      Get.snackbar("Success", "${user!.email} signed up successfully",
          backgroundColor: Colors.green, colorText: Colors.white);
      return true;
    } catch (e) {
      Get.snackbar(
          "Error", "Failed to sign up with Email & Password because $e",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      UserCredential userCredential;

      if (kIsWeb) {
        var googleProvider = GoogleAuthProvider();
        userCredential = await auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser!.authentication;
        final googleAuthCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        userCredential = await auth.signInWithCredential(googleAuthCredential);
      }

      user = userCredential.user;

      login.value = true;

      Get.snackbar("Success", "Sign In ${user!.email} with Google successfully",
          backgroundColor: Colors.green, colorText: Colors.white);
      return true;
    } catch (e) {
      Get.snackbar("Error", "Failed to sign in with Google because $e",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
  }
}
