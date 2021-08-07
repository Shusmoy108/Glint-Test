import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glinttest/controllers/userController.dart';
import 'package:glinttest/models/tweet.dart';
import 'package:glinttest/views/components/dialogue/dialoguehelper.dart';

class TwitterController {
  final UserController userController = Get.find();
  final CollectionReference tweets =
      FirebaseFirestore.instance.collection('Tweets');
  Future<void> addTweet(String tweet) async {
    await tweets.add({
      "tweet": tweet,
      "userId": userController.user?.uid,
      "email": userController.user?.email,
      "createdAt": DateTime.now().toIso8601String(),
      "supports": [] // 42
    }).then((value) {
      Get.snackbar("Success", "Your tweet has been added successfully",
          backgroundColor: Colors.green, colorText: Colors.white);
    }).catchError((error) {
      Get.snackbar("Error", "Failed to add your tweet: $error.",
          backgroundColor: Colors.red, colorText: Colors.white);
    });
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

  Future<void> deleteTweet(String tweetId) async {
    tweets.doc(tweetId).delete().then((value) {
      DialogueHelper.showDialogue(
          title: "Success!!",
          message: "Your tweet has been deleted successfully.");
    }).catchError((error) {
      DialogueHelper.showDialogue(
          title: "Error!!",
          message: "Something went wrong.Failed to delete your.");
    });
  }

  Future<void> editTweet(String tweetId, String tweet) async {
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
  }

  Future<void> supportTweet(String tweetId, String userId) async {
    DialogueHelper.showLoading();
    tweets
        .doc(tweetId)
        .update({
          'supports': FieldValue.arrayUnion([userId])
        })
        .then((value) => Get.snackbar(
            "Success", "Your have been supported the tweet successfully",
            backgroundColor: Colors.green, colorText: Colors.white))
        .catchError((error) => Get.snackbar(
            "Error", "Failed to support the tweet: $error.",
            backgroundColor: Colors.red, colorText: Colors.white));
    DialogueHelper.hideLoading();
  }

  Future<void> unsupportTweet(String tweetId, String userId) async {
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
            "Error", "Failed to unsupported the tweet: $error.",
            backgroundColor: Colors.red, colorText: Colors.white));
    DialogueHelper.hideLoading();
  }
}
