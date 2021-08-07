import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glinttest/controllers/twiterController.dart';
import 'package:glinttest/controllers/userController.dart';
import 'package:glinttest/models/tweet.dart';
import 'package:glinttest/views/components/tweetcart/tweetcart.dart';
import 'package:glinttest/views/components/input/tweetinput.dart';
import 'package:glinttest/views/screens/login/loginpage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final UserController userController = Get.put(UserController());
  final TwitterController twitterController = new TwitterController();
  List<Tweet> tweets = [];
  List<bool> addComment = [];
  logout() async {
    // userController.logOut();
    Get.off(LoginScreen());
  }

  @override
  void initState() {
    super.initState();
  }

  void viewCommentBox(int i) {
    print("object");
    setState(() {
      addComment[i] = !addComment[i];
    });
  }

  void support(String blogId) {
    //userController.addSupport(blogId);
  }

  void postcomment(comment, blogId) {
    // userController.postComment(comment, blogId);
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
                        twitterController.addTweet(textEditingController.text);
                        // userController.postBlog(textEditingController.text);
                        textEditingController.clear();
                        if (Get.isBottomSheetOpen == true) Get.back();
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
            // child: Text("My Profile",
            //     style: TextStyle(
            //       //fontStyle: FontStyle.italic,
            //       fontFamily: "Lucidasans",
            //       //fontWeight: FontWeight.bold
            //     )))
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
              return ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                  itemCount: tweets.length,
                  itemBuilder: (context, index) => BlogCart(tweets[index]));
            }
          },
        ),

        //  Container(
        //     padding: EdgeInsets.all(10),
        //     child: Center(
        //         child: Text("There is no blog at the moment. Post your blog."))
        // child: Obx(() {
        //   // if (userController.blogs.length > 0) {
        //   //   return ListView.separated(
        //   //     separatorBuilder: (context, i) {
        //   //       return SizedBox(height: 10);
        //   //     },
        //   //     itemCount: userController.blogs.length,
        //   //     itemBuilder: (context, i) {
        //   //       addComment.add(false);
        //   //       // return BlogCart(userController.blogs[i], addComment[i], i,
        //   //       //     this.viewCommentBox, this.postcomment, this.support);
        //   //     },
        //   //   );
        //   // } else {
        //   return
        //   );
        //   //}
        // }),
        //),
        floatingActionButton: addblog());
  }
}
