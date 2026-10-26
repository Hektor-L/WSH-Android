import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
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
  Future<String> requestProfilePicture (User user) async {
    final reqHandler = Dio();
    if(Platform.isAndroid) {
      final Directory appTempDir = await getTemporaryDirectory();
      final Directory appTempFolder = Directory('${appTempDir.path}/profile_pictures');
      if(await appTempFolder.exists()) {
        reqHandler.download('$imageBasePath/${user.webProfilePicturePath}', '${appTempFolder.path}/pfp${user.id}.jpg');
        return '${appTempFolder.path}/pfp${user.id}.jpg';
      } else {
        final Directory appTempNewFolder = await appTempFolder.create(recursive: true);
        reqHandler.download('$imageBasePath/${user.webProfilePicturePath}', '${appTempNewFolder.path}/pfp${user.id}.jpg');
        return '${appTempNewFolder.path}/pfp${user.id}.jpg';
      }
    } else {
      reqHandler.download('$imageBasePath/${user.webProfilePicturePath}', 'images/storage/profile_pictures/pfp${user.id}.jpg');
      return 'images/storage/profile_pictures/pfp${user.id}.jpg';
    }
  }
  Future<String> requestPostImage (Post post) async {
    final reqHandler = Dio();
    if(Platform.isAndroid) {
      final Directory appTempDir = await getTemporaryDirectory();
      final Directory appTempFolder = Directory('${appTempDir.path}/post_images');
      if(await appTempFolder.exists()) {
        reqHandler.download('$imageBasePath/${post.webImagePath}', '${appTempFolder.path}/post${post.id}.jpg');
        return '${appTempFolder.path}/post${post.id}.jpg';
      } else {
        final Directory appTempNewFolder = await appTempFolder.create(recursive: true);
        reqHandler.download('$imageBasePath/${post.webImagePath}', '${appTempNewFolder.path}/post${post.id}.jpg');
        return '${appTempNewFolder.path}/post${post.id}.jpg';
      }
    } else {
      reqHandler.download('$imageBasePath/${post.webImagePath}', 'images/storage/post_images/post${post.id}.jpg');
      return 'images/storage/post_images/post${post.id}.jpg';
    }
  }
}