import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:workservicehub_project/controllers/auth_controller.dart';
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
        List<User> userList = User.decode(jsonEncode(respUsers.data));
        for(User u in userList) {
          if(u.webProfilePicturePath.isNotEmpty) {
            u.profilePicturePath = await WebStorageService().requestProfilePicture(u);
            if(u.id == loginData.id) {
              AuthController.storeAuth(loginData.id, loginData.name, loginData.email, loginData.token,
                  loginData.tokenType, loginData.type, loginData.description, loginData.birthDate,
                  loginData.createdAt, await WebStorageService().requestProfilePicture(u));
            }
          }
        }
        LocalStorageService.saveUsers(userList);
      }
      loginData = (await LocalStorageService.loadAuth())!;
      Response respPosts = await WebStorageService().requestPostList(loginData.token);
      if (respPosts.data != null) {
        List<Post> newPostList = Post.decode(jsonEncode(respPosts.data));
        List<Post> currentPostList = await LocalStorageService.loadPosts();
        for(Post np in newPostList) {
          for(Post cp in currentPostList) {
            if(np.id == cp.id) {
              np.favorited = cp.favorited;
            }
          }
          if(np.webImagePath != '') {
            np.imagePath = await WebStorageService().requestPostImage(np);
          }
        }
        LocalStorageService.savePosts(newPostList);
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
    downloadData();
    Future.delayed(Duration(seconds: 3), () {
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
            Text('Carregando o Fórum. . .'),
            SizedBox(height: 15, width: 140,
              child: LinearProgressIndicator(backgroundColor: Colors.deepPurple, color: Colors.deepPurpleAccent),
            ),
          ],
        ),
      ),
    );
  }
}