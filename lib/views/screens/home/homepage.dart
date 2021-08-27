import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glinttest/controllers/twiterController.dart';
import 'package:glinttest/controllers/userController.dart';
import 'package:glinttest/models/tweet.dart';
import 'package:glinttest/views/components/tweetcart/tweetcart.dart';
import 'package:glinttest/views/components/input/tweetinput.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final UserController userController = Get.put(UserController());
  final TwitterController twitterController = new TwitterController();
  List<Tweet> tweets = [];
  @override
  void initState() {
    super.initState();
  }

  Future<bool> loadTweets() async {
    List<Tweet> t = await twitterController.loadTweets();
    setState(() {
      tweets = t;
    });
    return true;
  }

  final TextEditingController textEditingController =
      new TextEditingController();
  Widget addblog() {
    return InkWell(
      onTap: () {
        // loadTweets();
        //logout();
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
                        if (textEditingController.text.length != 0) {
                          twitterController
                              .addTweet(textEditingController.text);
                          // userController.postBlog(textEditingController.text);
                          textEditingController.clear();
                        }

                        if (Get.isBottomSheetOpen == true) Get.back();
                      },
                      child: Text("Post Tweet",
                          style: TextStyle(
                            fontFamily: "Lucidasans",
                          )))
                ],
              )
            ],
          ),
        ));
      },
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            //BoxShadow(color: Colors.grey, offset: Offset(1, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Add Tweet',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontFamily: 'Lucidasans'),
            ),
            SizedBox(
              width: 0.0,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Twitter",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontFamily: "Lucidasans",
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                userController.signOut();
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: loadTweets(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              if (tweets.length > 0) {
                return ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: tweets.length,
                    itemBuilder: (context, index) => BlogCart(tweets[index]));
              } else {
                return Center(
                  child: Text(
                      "There is no tweet at the moment. Post your first tweet.",
                      style: TextStyle(
                        fontFamily: "Lucidasans",
                      )),
                );
              }
            }
          },
        ),
        floatingActionButton: addblog());
  }
}
