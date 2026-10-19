import 'dart:io';
import 'package:dio/dio.dart';
import 'package:workservicehub_project/models/classes/post.dart';
import 'package:workservicehub_project/models/classes/user.dart';

class WebStorageService {
  static String loginUrl = "https://workservicehub.wasmer.app/api/auth/login";
  static String logoutUrl = "https://workservicehub.wasmer.app/api/auth/logout";
  static String profileUrl = "https://workservicehub.wasmer.app/api/auth/user";
  static String userListUrl = "https://workservicehub.wasmer.app/api/users";
  static String postListUrl = "https://workservicehub.wasmer.app/api/posts";
  static String commentListUrl = "https://workservicehub.wasmer.app/api/comments";
  static String categoryListUrl = "https://workservicehub.wasmer.app/api/categories";
  static String imageBasePath = "https://workservicehub.wasmer.app/storage";

  Future<Response> requestLogin (String email, String password) async {
    final reqHandler = Dio();
    return await reqHandler.post(loginUrl, data: {'email': email, 'password': password});
  }
  Future<Response> requestLogout (String token) async {
    final reqHandler = Dio();
    reqHandler.options.headers['Authorization'] = 'Bearer $token';
    return await reqHandler.get(logoutUrl);
  }
  Future<Response> requestProfile (String token) async {
    final reqHandler = Dio();
    reqHandler.options.headers['Authorization'] = 'Bearer $token';
    return await reqHandler.get(profileUrl);
  }
  Future<Response> requestUserList (String token) async {
    final reqHandler = Dio();
    reqHandler.options.headers['Authorization'] = 'Bearer $token';
    return await reqHandler.get(userListUrl);
  }
  Future<Response> requestPostList (String token) async {
    final reqHandler = Dio();
    reqHandler.options.headers['Authorization'] = 'Bearer $token';
    return await reqHandler.get(postListUrl);
  }
  Future<Response> requestCommentList (String token) async {
    final reqHandler = Dio();
    reqHandler.options.headers['Authorization'] = 'Bearer $token';
    return await reqHandler.get(commentListUrl);
  }
  Future<Response> requestCategoryList (String token) async {
    final reqHandler = Dio();
    reqHandler.options.headers['Authorization'] = 'Bearer $token';
    return await reqHandler.get(categoryListUrl);
  }
  String requestProfilePicture (User user) {
    final reqHandler = Dio();
    if(Platform.isAndroid) {
      reqHandler.download('$imageBasePath/${user.webProfilePicturePath}', 'Android/media/com.ifmg.hektorl.workservicehub/profile_pictures/pfp${user.id}.jpg');
      return 'Android/media/com.ifmg.hektorl.workservicehub/profile_pictures/pfp${user.id}.jpg';
    } else {
      reqHandler.download('$imageBasePath/${user.webProfilePicturePath}', 'images/storage/profile_pictures/pfp${user.id}.jpg');
      return 'images/storage/profile_pictures/pfp${user.id}.jpg';
    }
  }
  String requestPostImage (Post post) {
    final reqHandler = Dio();
    if(Platform.isAndroid) {
      reqHandler.download('$imageBasePath/${post.webImagePath}', 'Android/media/com.ifmg.hektorl.workservicehub/post_images/post${post.id}.jpg');
      return 'Android/media/com.ifmg.hektorl.workservicehub/post_images/post${post.id}.jpg';
    } else {
      reqHandler.download('$imageBasePath/${post.webImagePath}', 'images/storage/post_images/post${post.id}.jpg');
      return 'images/storage/post_images/post${post.id}.jpg';
    }
  }
}