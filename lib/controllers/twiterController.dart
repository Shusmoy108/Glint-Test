import 'package:firebase_database/firebase_database.dart';
import 'package:glinttest/models/tweet.dart';

class TwitterController {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  late DatabaseReference databaseReference =
      database.reference().child("twitter");
  void addTweet(Tweet tweet) {
    databaseReference.push().set(tweet.toJson());
  }
}
