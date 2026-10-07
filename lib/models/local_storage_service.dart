import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:workservicehub_project/models/classes/auth.dart';
import 'package:workservicehub_project/models/classes/category.dart';
import 'package:workservicehub_project/models/classes/comment.dart';
import 'package:workservicehub_project/models/classes/post.dart';
import 'package:workservicehub_project/models/classes/user.dart';

class LocalStorageService {
  static const String postList = 'lista_posts';
  static const String commentList = 'lista_comments';
  static const String userList = 'lista_users';
  static const String categoryList = 'lista_categories';
  static const String interestList = 'lista_interests';
  static const String authData =  'auth';
  static Future<void> storeAuth(Auth auth) async {
    final SharedPreferences sPrefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(auth.toMap());
    await sPrefs.setString(authData, encodedData);
  }
  static Future<void> unloadAuth() async {
    final SharedPreferences sPrefs = await SharedPreferences.getInstance();
    await sPrefs.remove(authData);
  }
  static Future<Auth?> loadAuth() async {
    final SharedPreferences sPrefs = await SharedPreferences.getInstance();
    final String? authJson = sPrefs.getString(authData);
    if (authJson == null) return null;
    return Auth.fromMap(json.decode(authJson));
  }
  static Future<void> savePosts(List<Post> lista) async {
    final SharedPreferences sPrefs = await SharedPreferences.getInstance();
    final String encodedData = Post.encode(lista);
    await sPrefs.setString(postList, encodedData);
  }
  static Future<List<Post>> loadPosts() async {
    final SharedPreferences sPrefs = await SharedPreferences.getInstance();
    final String? postsJson = sPrefs.getString(postList);
    if (postsJson == null) {return [];}
    else {return Post.decode(postsJson);}
  }

  static Future<void> saveUsers(List<User> lista) async {
    final SharedPreferences sPrefs = await SharedPreferences.getInstance();
    final String encodedData = User.encode(lista);
    await sPrefs.setString(userList, encodedData);
  }
  static Future<List<User>> loadUsers() async {
    final SharedPreferences sPrefs = await SharedPreferences.getInstance();
    final String? userJson = sPrefs.getString(userList);
    if (userJson == null) {return [];}
    else {return User.decode(userJson);}
  }

  static Future<void> saveComments(List<Comment> lista) async{
    final SharedPreferences sPrefs = await SharedPreferences.getInstance();
    final String encodedData = Comment.encode(lista);
    await sPrefs.setString(commentList, encodedData);
  }
  static Future<List<Comment>> loadComments() async {
    final SharedPreferences sPrefs = await SharedPreferences.getInstance();
    final String? commentsJson = sPrefs.getString(commentList);
    if (commentsJson == null) {return [];}
    else {return Comment.decode(commentsJson);}
  }

  static Future<void> saveCategories(List<Category> lista) async {
    final SharedPreferences sPrefs = await SharedPreferences.getInstance();
    final String encodedData = Category.encode(lista);
    await sPrefs.setString(categoryList, encodedData);
  }
  static Future<List<Category>> loadCategories() async {
    final SharedPreferences sPrefs = await SharedPreferences.getInstance();
    final String? categoriesJson = sPrefs.getString(categoryList);
    if (categoriesJson == null) {return [];}
    else {return Category.decode(categoriesJson);}
  }

  static Future<void> saveInterests(List<Category> lista) async {
    final SharedPreferences sPrefs = await SharedPreferences.getInstance();
    final String encodedData = Category.encode(lista);
    await sPrefs.setString(categoryList, encodedData);
  }
  static Future<List<Category>> loadInterests() async {
    final SharedPreferences sPrefs = await SharedPreferences.getInstance();
    final String? interestsJson = sPrefs.getString(interestList);
    if (interestsJson == null) {return [];}
    else {return Category.decode(interestsJson);}
  }
}