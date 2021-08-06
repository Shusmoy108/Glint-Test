import 'dart:convert';

Tweet tweetFromJson(String str) => Tweet.fromJson(json.decode(str));

String tweetToJson(Tweet data) => json.encode(data.toJson());

class Tweet {
  Tweet({
    required this.tweet,
    required this.userId,
    required this.userName,
    required this.createdAt,
  });

  String tweet;
  String userId;
  String userName;
  DateTime createdAt;

  factory Tweet.fromJson(Map<String, dynamic> json) => Tweet(
        tweet: json["tweet"],
        userId: json["userId"],
        userName: json["userName"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "tweet": tweet,
        "userId": userId,
        "userName": userName,
        "createdAt": createdAt.toIso8601String(),
      };
}
