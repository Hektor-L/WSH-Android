import 'package:workservicehub_project/models/classes/post.dart';
import 'package:workservicehub_project/models/local_storage_service.dart';

class PostListController {
  static Future<void> insertPost(int id, String title, String description, DateTime postDate, int posterId, int categoryId) async {
    List<Post> list = await LocalStorageService.loadPosts();
    list.add(Post(id: id, title: title, description: description, createdAt: postDate, posterId: posterId, categoryId: categoryId, favorited: false));
    await LocalStorageService.savePosts(list);
  }
  static Future<void> deletePost(int id) async {
    List<Post> list = await LocalStorageService.loadPosts();
    for(Post p in list){
      if(p.id == id) {
        list.remove(p);
        break;
      }
    }
    await LocalStorageService.savePosts(list);
  }
  static Future<void> favorite(Post post) async {
    Post postFavorite = post;
    postFavorite.favorited = !postFavorite.favorited;
    await updatePost(postFavorite);
  }
  static Future<void> updatePost(Post post) async {
    List<Post> list = await LocalStorageService.loadPosts();
    int index = 0;
    for(Post p in list) {
      if (p.id == post.id) {
        list.removeAt(index);
        break;
      }
      index++;
    }
    list.add(post);
    await LocalStorageService.savePosts(list);
  }
  static Future<List<Post>> searchPosts(String keyword) async {
    List<Post> list = await LocalStorageService.loadPosts();
    int i = 0;
    for(Post p in list) {
      if(p.title != keyword) {
        list.removeAt(i);
      }
      i++;
    }
    return list;
  }
  static Future<Post> findPost(int id) async {
    List<Post> list = await LocalStorageService.loadPosts();
    return list.firstWhere((instance) => instance.id == id);
  }
  static Future<List<Post>> listPosts() async {
    return await LocalStorageService.loadPosts();
  }
}