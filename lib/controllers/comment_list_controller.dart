import 'package:workservicehub_project/models/classes/comment.dart';
import 'package:workservicehub_project/models/classes/post.dart';
import 'package:workservicehub_project/models/local_storage_service.dart';

class CommentListController {
  static Future<void> insertComment(int id, String text, DateTime createdAt, int commenterId, int postId) async {
    List<Comment> list = await LocalStorageService.loadComments();
    list.add(Comment(id: id, text: text, createdAt: createdAt, commenterId: commenterId, postId: postId));
    await LocalStorageService.saveComments(list);
  }
  static Future<void> deletePost(int id) async {
    List<Comment> list = await LocalStorageService.loadComments();
    for(Comment c in list){
      if(c.id == id) {
        list.remove(c);
        break;
      }
    }
    await LocalStorageService.saveComments(list);
  }
  static Future<List<Comment>> listComments(Post post) async {
    List<Comment> list = await LocalStorageService.loadComments();
    return list.where((instance) => instance.postId == post.id).toList();
  }

}