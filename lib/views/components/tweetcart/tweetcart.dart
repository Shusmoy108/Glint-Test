import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glinttest/controllers/twiterController.dart';
import 'package:glinttest/controllers/userController.dart';
import 'package:glinttest/models/tweet.dart';
import 'package:glinttest/views/components/input/tweetinput.dart';

class BlogCart extends StatelessWidget {
  final Tweet tweet;
  late final TextEditingController textEditingController =
      new TextEditingController(text: tweet.tweet);
  final UserController userController = Get.find();
  final TwitterController twitterController = new TwitterController();
  BlogCart(this.tweet);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tweet.email,
                    style: TextStyle(
                        fontFamily: "Lucidasans", fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${tweet.createdAt.day}/${tweet.createdAt.month}/${tweet.createdAt.year}",
                    style: TextStyle(
                        fontFamily: "Lucidasans", fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(tweet.tweet,
                  style: TextStyle(
                    fontFamily: "Lucidasans",
                  )),
              SizedBox(
                height: 10,
              ),
              Text("${tweet.supports.length} people support this tweet.",
                  style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Comicsans",
                  )),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  tweet.supports.contains(userController.user?.uid)
                      ? ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.pink)),
                          onPressed: () async {
                            await twitterController.unsupportTweet(
                                tweet.id!, userController.user!.uid);
                          },
                          child: Text("Unsupport",
                              style: TextStyle(fontFamily: "Lucidasans")))
                      : ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green)),
                          onPressed: () async {
                            await twitterController.supportTweet(
                                tweet.id!, userController.user!.uid);
                          },
                          child: Text("Support",
                              style: TextStyle(fontFamily: "Lucidasans"))),
                  (userController.user?.uid == tweet.userId)
                      ? ElevatedButton(
                          onPressed: () {
                            Get.dialog(Dialog(
                                child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Attention!!!",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Lucidasans"),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Are you sure you want to delete the tweet?",
                                    style: TextStyle(
                                        fontFamily: "Lucidasans", fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 50,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.red)),
                                          child: Text("No",
                                              style: TextStyle(
                                                fontFamily: "Lucidasans",
                                              ))),
                                      ElevatedButton(
                                          onPressed: () {
                                            twitterController
                                                .deleteTweet(tweet.id!);
                                            Get.back();
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.green)),
                                          child: Text("Yes",
                                              style: TextStyle(
                                                fontFamily: "Lucidasans",
                                              )))
                                    ],
                                  )
                                ],
                              ),
                            )));

                            //this.support(blog.id);
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                          child: Text("Delete",
                              style: TextStyle(
                                fontFamily: "Lucidasans",
                              )))
                      : SizedBox(),
                  (userController.user?.uid == tweet.userId)
                      ? ElevatedButton(
                          onPressed: () {
                            Get.bottomSheet(Container(
                              color: Colors.grey.shade300,
                              padding: EdgeInsets.all(10),
                              child: ListView(
                                children: [
                                  Center(
                                      child: Text("Edit Your Tweet",
                                          style: TextStyle(
                                            fontFamily: "Lucidasans",
                                            fontSize: 18,
                                            color: Colors.black,
                                          ))),
                                  Divider(
                                    thickness: 2,
                                    color: Colors.black,
                                  ),
                                  BlogInput(textEditingController),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            twitterController.editTweet(
                                                tweet.id!,
                                                textEditingController.text);
                                            // userController.postBlog(textEditingController.text);
                                            textEditingController.clear();
                                            if (Get.isBottomSheetOpen == true)
                                              Get.back();
                                          },
                                          child: Text("Edit Tweet",
                                              style: TextStyle(
                                                fontFamily: "Lucidasans",
                                              )))
                                    ],
                                  )
                                ],
                              ),
                            ));
                            // this.view(index);
                          },
                          child: Text("Edit"))
                      : SizedBox(),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          )),
    );
  }
}
