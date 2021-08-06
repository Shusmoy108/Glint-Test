import 'dart:convert';

Tweet tweetFromJson(String str) => Tweet.fromJson(json.decode(str));
String tweetToJson(Tweet data) => json.encode(data.toJson());

class Tweet {
  Tweet({
    required this.tweet,
    required this.userId,
    required this.email,
    required this.createdAt,
  });
  String? id;
  String tweet;
  String userId;
  String email;
  DateTime createdAt;

  factory Tweet.fromJson(Map<String, dynamic> json) => Tweet(
        tweet: json["tweet"],
        userId: json["userId"],
        email: json["email"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tweet": tweet,
        "userId": userId,
        "email": email,
        "createdAt": createdAt.toIso8601String(),
      };
}
