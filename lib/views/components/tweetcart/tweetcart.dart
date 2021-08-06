import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glinttest/controllers/twiterController.dart';
import 'package:glinttest/controllers/userController.dart';
import 'package:glinttest/models/tweet.dart';
import 'package:glinttest/views/components/input/tweetinput.dart';

class BlogCart extends StatelessWidget {
  final Tweet tweet;
  final int index;
  late final TextEditingController textEditingController =
      new TextEditingController(text: tweet.tweet);
  final UserController userController = Get.find();
  final TwitterController twitterController = new TwitterController();
  BlogCart(this.tweet, this.index);

  void deleteComment(String commentId) {
    // userController.deleteComment(commentId, blog.id);
  }

  List<Widget> getcomments() {
    List<Widget> childs = [];
    // for (var i = 0; i < blog.comments.length; i++) {
    //   bool delete = (blog.userId.trim() == userController.id.trim()) ||
    //       (blog.comments[i].userId.trim() == userController.id.trim());

    //   childs.add(CommentCart(blog.comments[i], delete, deleteComment));
    //   childs.add(Divider(
    //     thickness: 1,
    //     color: Colors.grey,
    //   ));
    // }
    return childs;
  }

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
              Text("",
                  style: TextStyle(
                    fontFamily: "Lucidasans",
                  )),
              SizedBox(
                height: 10,
              ),
              (userController.user?.uid == tweet.userId)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              twitterController.deleteTweet(tweet.id!);
                              //this.support(blog.id);
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                            child: Text("Delete Tweet",
                                style: TextStyle(
                                  fontFamily: "Lucidasans",
                                ))),
                        ElevatedButton(
                            onPressed: () {
                              Get.bottomSheet(Container(
                                color: Colors.grey.shade300,
                                padding: EdgeInsets.all(10),
                                child: ListView(
                                  children: [
                                    Center(
                                        child: Text("Post Your Tweet",
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
                                            child: Text("Post",
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
                            child: Text("Edit Tweet")),
                      ],
                    )
                  : SizedBox(),
              SizedBox(
                height: 10,
              ),
            ],
          )),
    );
  }
}
