import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:workservicehub_project/models/classes/auth.dart';
import 'package:workservicehub_project/models/classes/category.dart';
import 'package:workservicehub_project/models/classes/comment.dart';
import 'package:workservicehub_project/models/classes/post.dart';
import 'package:workservicehub_project/models/classes/user.dart';

class LocalStorageService {
  static const String LISTA_POSTS = 'lista_posts';
  static const String LISTA_COMMENTS = 'lista_comments';
  static const String LISTA_USERS = 'lista_users';
  static const String LISTA_CATEGORIES = 'lista_categories';
  static const String LISTA_INTERESTS = 'lista_interests';
  static const String AUTH =  'auth';
  static Future<void> storeAuth(Auth auth) async {
    final SharedPreferences sPrefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(auth.toMap());
    await sPrefs.setString(AUTH, encodedData);
  }
  static Future<void> unloadAuth() async {
    final SharedPreferences sPrefs = await SharedPreferences.getInstance();
    await sPrefs.remove(AUTH);
  }
  static Future<Auth?> loadAuth() async {
    final SharedPreferences sPrefs = await SharedPreferences.getInstance();
    final String? authJson = sPrefs.getString(AUTH);
    if (authJson == null) return null;
    return Auth.fromMap(json.decode(authJson));
  }
  static Future<void> savePosts(List<Post> lista) async {
    final SharedPreferences sPrefs = await SharedPreferences.getInstance();
    final String encodedData = Post.encode(lista);
    await sPrefs.setString(LISTA_POSTS, encodedData);
  }
  static Future<List<Post>> loadPosts() async {
    final SharedPreferences sPrefs = await SharedPreferences.getInstance();
    final String? postsJson = sPrefs.getString(LISTA_POSTS);
    if (postsJson == null) {return [];}
    else {return Post.decode(postsJson);}
  }

  static Future<void> saveUsers(List<User> lista) async {
    final SharedPreferences sPrefs = await SharedPreferences.getInstance();
    final String encodedData = User.encode(lista);
    await sPrefs.setString(LISTA_USERS, encodedData);
  }
  static Future<List<User>> loadUsers() async {
    final SharedPreferences sPrefs = await SharedPreferences.getInstance();
    final String? userJson = sPrefs.getString(LISTA_USERS);
    if (userJson == null) {return [];}
    else {return User.decode(userJson);}
  }

  static Future<void> saveComments(List<Comment> lista) async{
    final SharedPreferences sPrefs = await SharedPreferences.getInstance();
    final String encodedData = Comment.encode(lista);
    await sPrefs.setString(LISTA_COMMENTS, encodedData);
  }
  static Future<List<Comment>> loadComments() async {
    final SharedPreferences sPrefs = await SharedPreferences.getInstance();
    final String? commentsJson = sPrefs.getString(LISTA_COMMENTS);
    if (commentsJson == null) {return [];}
    else {return Comment.decode(commentsJson);}
  }

  static Future<void> saveCategories(List<Category> lista) async {
    final SharedPreferences sPrefs = await SharedPreferences.getInstance();
    final String encodedData = Category.encode(lista);
    await sPrefs.setString(LISTA_CATEGORIES, encodedData);
  }
  static Future<List<Category>> loadCategories() async {
    final SharedPreferences sPrefs = await SharedPreferences.getInstance();
    final String? categoriesJson = sPrefs.getString(LISTA_CATEGORIES);
    if (categoriesJson == null) {return [];}
    else {return Category.decode(categoriesJson);}
  }

  static Future<void> saveInterests(List<Category> lista) async {
    final SharedPreferences sPrefs = await SharedPreferences.getInstance();
    final String encodedData = Category.encode(lista);
    await sPrefs.setString(LISTA_CATEGORIES, encodedData);
  }
  static Future<List<Category>> loadInterests() async {
    final SharedPreferences sPrefs = await SharedPreferences.getInstance();
    final String? interestsJson = sPrefs.getString(LISTA_INTERESTS);
    if (interestsJson == null) {return [];}
    else {return Category.decode(interestsJson);}
  }
}