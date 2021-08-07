import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glinttest/controllers/userController.dart';
import 'package:glinttest/models/tweet.dart';
import 'package:glinttest/views/components/dialogue/dialoguehelper.dart';

class TwitterController {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final UserController userController = Get.find();
  final CollectionReference tweets =
      FirebaseFirestore.instance.collection('Tweets');
  late DatabaseReference databaseReference =
      database.reference().child("twitter");
  bool addTweet(String tweet) {
    bool sucess = false;
    tweets.add({
      "tweet": tweet,
      "userId": userController.user?.uid,
      "email": userController.user?.email,
      "createdAt": DateTime.now().toIso8601String(),
      "supports": [] // 42
    }).then((value) {
      Get.snackbar("Success", "Your tweet has been added successfully",
          backgroundColor: Colors.green, colorText: Colors.white);
      sucess = true;
    }).catchError((error) {
      Get.snackbar("Error", "Failed to add your tweet: $error.",
          backgroundColor: Colors.red, colorText: Colors.white);
      sucess = false;
    });
    return sucess;
    // databaseReference.push().set(tweet.toJson());
  }

  Future<List<Tweet>> loadTweets() async {
    List<Tweet> tweetList = [];
    await tweets
        .orderBy('createdAt', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Tweet t = Tweet(
            createdAt: DateTime.parse((doc['createdAt'])),
            email: doc['email'],
            userId: doc['userId'],
            tweet: doc['tweet'],
            supports: List<String>.from(doc["supports"].map((x) => x)));
        t.id = doc.id;
        tweetList.add(t);
      });
    });

    return tweetList;
  }

  Future<bool> deleteTweet(String tweetId) async {
    bool sucess = false;
    tweets.doc(tweetId).delete().then((value) {
      sucess = true;
      DialogueHelper.showDialogue(
          title: "Success!!",
          message: "Your tweet has been deleted successfully.");
    }).catchError((error) {
      DialogueHelper.showDialogue(
          title: "Error!!",
          message: "Something went wrong.Failed to delete your.");
      sucess = false;
    });

    return sucess;
  }

  Future<bool> editTweet(String tweetId, String tweet) async {
    DialogueHelper.showLoading();
    tweets
        .doc(tweetId)
        .update({'tweet': tweet})
        .then((value) => Get.snackbar(
            "Success", "Your tweet has been updated successfully",
            backgroundColor: Colors.green, colorText: Colors.white))
        .catchError((error) => Get.snackbar(
            "Error", "Failed to update your tweet: $error.",
            backgroundColor: Colors.red, colorText: Colors.white));
    DialogueHelper.hideLoading();
    return true;
  }

  Future<bool> supportTweet(String tweetId, String userId) async {
    DialogueHelper.showLoading();
    tweets
        .doc(tweetId)
        .update({
          'supports': FieldValue.arrayUnion([userId])
        })
        .then((value) => Get.snackbar(
            "Success", "Your have been suported the tweet successfully",
            backgroundColor: Colors.green, colorText: Colors.white))
        .catchError((error) => Get.snackbar(
            "Error", "Failed to support the tweet: $error.",
            backgroundColor: Colors.red, colorText: Colors.white));
    DialogueHelper.hideLoading();
    return true;
  }

  Future<bool> unsupportTweet(String tweetId, String userId) async {
    DialogueHelper.showLoading();
    tweets
        .doc(tweetId)
        .update({
          'supports': FieldValue.arrayRemove([userId])
        })
        .then((value) => Get.snackbar(
            "Success", "Your have been unsuported the tweet successfully",
            backgroundColor: Colors.green, colorText: Colors.white))
        .catchError((error) => Get.snackbar(
            "Error", "Failed to unsuported the tweet: $error.",
            backgroundColor: Colors.red, colorText: Colors.white));
    DialogueHelper.hideLoading();
    return true;
  }
}
