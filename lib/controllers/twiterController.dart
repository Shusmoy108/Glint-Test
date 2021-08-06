import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
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
      "createdAt": DateTime.now().toIso8601String(), // 42
    }).then((value) {
      print("Tweet Added");
      sucess = true;
    }).catchError((error) {
      print("Failed to add tweet: $error");
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
            tweet: doc['tweet']);
        t.id = doc.id;
        tweetList.add(t);
      });
    });

    return tweetList;
  }

  Future<bool> deleteTweet(String tweetId) async {
    DialogueHelper.showLoading();
    tweets
        .doc(tweetId)
        .delete()
        .then((value) => print("Tweet Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
    DialogueHelper.hideLoading();
    return true;
  }

  Future<bool> editTweet(String tweetId, String tweet) async {
    DialogueHelper.showLoading();
    tweets
        .doc(tweetId)
        .update({'tweet': tweet})
        .then((value) => print("Tweet Updated"))
        .catchError((error) => print("Failed to update tweet: $error"));
    DialogueHelper.hideLoading();
    return true;
  }
}
