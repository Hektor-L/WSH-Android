import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:workservicehub_project/models/classes/category.dart';
import 'package:workservicehub_project/models/classes/comment.dart';
import 'package:workservicehub_project/models/classes/post.dart';
import 'package:workservicehub_project/models/classes/user.dart';
import 'package:workservicehub_project/models/local_storage_service.dart';
import 'package:workservicehub_project/models/web_storage_service.dart';
import 'package:workservicehub_project/views/app_menu.dart';
import 'package:workservicehub_project/views/splash1.dart';

class Splash2 extends StatefulWidget{
  const Splash2({super.key});
  @override
  State<Splash2> createState() => _Splash2State();
}
class _Splash2State extends State<Splash2> {
  void downloadData() async {
    try{
      loginData = (await LocalStorageService.loadAuth())!;
      Response respUsers = await WebStorageService().requestUserList(loginData.token);
      if (respUsers.data != null) {
        LocalStorageService.saveUsers(User.decode(jsonEncode(respUsers.data)));
      }
      Response respPosts = await WebStorageService().requestPostList(loginData.token);
      if (respPosts.data != null) {
        LocalStorageService.savePosts(Post.decode(jsonEncode(respPosts.data)));
      }
      Response respComments = await WebStorageService().requestCommentList(loginData.token);
      if (respComments.data != null) {
        LocalStorageService.saveComments(Comment.decode(jsonEncode(respComments.data)));
      }
      Response respCategories = await WebStorageService().requestCategoryList(loginData.token);
      if (respCategories.data != null) {
        LocalStorageService.saveCategories(Category.decode(jsonEncode(respCategories.data)));
      }
    }catch(x){
      print('Thrown an error when trying to load data from web: $x');
    }
  }
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      downloadData();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppMenu()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            Text('Loading Forum. . .'),
            SizedBox(height: 15, width: 140,
              child: LinearProgressIndicator(backgroundColor: Colors.deepPurple, color: Colors.deepPurpleAccent,),
            ),
          ],
        ),
      ),
    );
  }
}