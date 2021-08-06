import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glinttest/controllers/userController.dart';

import 'package:glinttest/views/components/input/bloginput.dart';
import 'package:glinttest/views/screens/login/loginpage.dart';
import 'package:glinttest/views/screens/profile/profilepage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final UserController userController = Get.put(UserController());
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

  final TextEditingController textEditingController =
      new TextEditingController();
  Widget addblog() {
    return InkWell(
      onTap: () {
        //logout();
        Get.bottomSheet(Container(
          color: Colors.grey.shade300,
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Center(
                  child: Text("Post Your Blog",
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
              'Add Blog',
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
        body: Container(
            padding: EdgeInsets.all(10),
            child: Center(
                child: Text("There is no blog at the moment. Post your blog."))
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
            ),
        floatingActionButton: addblog());
  }
}
