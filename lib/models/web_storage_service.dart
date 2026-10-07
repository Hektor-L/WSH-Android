import 'package:dio/dio.dart';

class WebStorageService {
  static String loginUrl = "http://127.0.0.1:8000/api/auth/login";
  static String logoutUrl = "http://127.0.0.1:8000/api/auth/logout";
  static String profileUrl = "http://127.0.0.1:8000/api/auth/user";
  static String userListUrl = "http://127.0.0.1:8000/api/users";
  static String postListUrl = "http://127.0.0.1:8000/api/posts";
  static String commentListUrl = "http://127.0.0.1:8000/api/comments";
  static String categoryListUrl = "http://127.0.0.1:8000/api/categories";

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
}