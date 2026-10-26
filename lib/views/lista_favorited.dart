import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workservicehub_project/controllers/user_list_controller.dart';
import 'package:workservicehub_project/models/classes/comment.dart';
import 'package:workservicehub_project/models/classes/post.dart';
import 'package:workservicehub_project/controllers/post_list_controller.dart';
import 'package:workservicehub_project/controllers/comment_list_controller.dart';
import 'package:workservicehub_project/models/classes/user.dart';

class ListaFavorited extends StatefulWidget {
  const ListaFavorited({super.key});
  @override
  State<ListaFavorited> createState() => _ListaFavoritedState();
}

class _ListaFavoritedState extends State<ListaFavorited> {
  final List<Post> _posts = [];
  final List<User> _posters = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    try {
      final data = await PostListController.listPosts();
      for(Post p in data){
        if(p.favorited == true) {
          _posts.add(p);
        } else {continue;}
        _posters.add(await UserListController.findUser(p.posterId));
      }
    } catch(x) {
      ScaffoldMessenger.of(context).showSnackBar(.new(content: Text('Sem dados persistidos.')));
    }
  }

  void favorite(Post p) async {
    await PostListController.favorite(p);
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(future: PostListController.listPosts(), builder: (context, snapshot) {
            List<Widget> postLoaded;
            if(snapshot.hasData){
              postLoaded = [
                Expanded(
                  child: ListView.builder(itemCount: _posts.length, itemBuilder: (context, index) {
                    final post = _posts[index];
                    final poster = _posters[index];
                    return Card(
                      child: ListTile(
                        title: Text(post.title),
                        subtitle: Text('Publicado em ${post.createdAt.toString()} por ${poster.name}'),
                        trailing: IconButton(onPressed: () {favorite(post);},
                            icon: post.favorited
                                ? Icon(Icons.favorite, color: Colors.redAccent)
                                : Icon(Icons.favorite_border)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (context) => PostDetails(post: post, poster: poster,)
                              )
                          );
                        },
                      ),
                    );
                  }
                  ),
                )
              ];
            } else {
              postLoaded = [
                Text('Loading Post list. . .'),
                SizedBox(
                    width: 200,
                    height: 20,
                    child: LinearProgressIndicator(backgroundColor: Colors.deepPurple, color: Colors.deepPurpleAccent,))
              ];
            }
            return Column(
                mainAxisAlignment: .center,
                children: postLoaded
            );
          })

      ),
    );
  }
}
class PostDetails extends StatefulWidget {
  const PostDetails({super.key, required this._post, required this._poster});
  final Post _post;
  final User _poster;
  @override
  State<PostDetails> createState() => _PostDetailsState();
}
class _PostDetailsState extends State<PostDetails> {
  TextEditingController tecText = TextEditingController();
  late List<Comment> _comments = [];
  final List<User> _commenters = [];
  @override
  void initState() {
    super.initState();
    loadData();
  }
  void loadData() async {
    try {
      final commentData = await CommentListController.listComments(widget._post, Comment.fromMap(<String, dynamic>{}));
      setState(() {
        _comments = commentData;
      });
      for(Comment c in commentData) {
        _commenters.add(await UserListController.findUser(c.commenterId));
      }
    } catch(x) {
      ScaffoldMessenger.of(context).showSnackBar(.new(content: Text('Sem dados persistidos $x')));
    }
  }
  Future<List<Comment>> findChildCommentsList(Comment parentComment) async {
    final data = await CommentListController.listComments(Post.fromMap(<String, dynamic>{}), parentComment);
    return data;
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes da Publicação')),
      body: Padding(padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(widget._post.title, style: TextStyle(fontSize: 20)),
              Text('Publicado em ${widget._post.createdAt.day}/${widget._post.createdAt.month}/${widget._post.createdAt.year} às '
                  '${widget._post.createdAt.hour}:${widget._post.createdAt.minute}:${widget._post.createdAt.second}, por ${widget._poster.name}',
                  style: TextStyle(color: CupertinoColors.systemGrey)),
              Text(widget._post.description),
              widget._post.imagePath.isNotEmpty
                  ? Platform.isAndroid ? Image.file(File(widget._post.imagePath), height: 300) : Image.asset(widget._post.imagePath, height: 300)
                  : SizedBox(),
              const SizedBox(height: 20,),
              const Text('Comments:'),
              const SizedBox(height: 12,),
              Expanded(
                  child: _comments.isEmpty
                      ? const Center(child: Text('No comments in this post.'))
                      : ListView.builder(
                      itemCount: _comments.length,
                      itemBuilder: (context, index) {
                        final comment = _comments[index];
                        final commenter = _commenters[index];
                        return Card (
                            color: Colors.white,
                            child: Column(children: [
                              ListTile(
                                leading:
                                SizedBox(height: 45, width: 45,
                                  child: ClipRRect(
                                      borderRadius: BorderRadiusGeometry.circular(25),
                                      clipBehavior: Clip.antiAlias,
                                      child: commenter.profilePicturePath.isEmpty
                                          ? Image.asset('images/WorkServiceHub-DefaultProfilePic.png')
                                          : Platform.isAndroid ? Image.file(File(commenter.profilePicturePath)) : Image.asset(commenter.profilePicturePath)
                                  ),
                                ),
                                title: Text(commenter.name),
                                subtitle: Text(comment.text),
                              ),
                              FutureBuilder(future: CommentListController.listComments(Post.fromMap(<String, dynamic>{}), comment), builder: (context, snapshot) {
                                if(snapshot.hasData) {
                                  final List<Comment> childComments = snapshot.data!;
                                  final List<Widget> childCommentsLoaded;
                                  childCommentsLoaded = [
                                    for(Comment cc in childComments)
                                      FutureBuilder(future: UserListController.findUser(cc.commenterId), builder: (context, snapshot) {
                                        if(snapshot.hasData) {
                                          final User childCommenter = snapshot.data!;
                                          return ListTile(
                                            leading:
                                            SizedBox(height: 45, width: 45,
                                              child: ClipRRect(
                                                  borderRadius: BorderRadiusGeometry.circular(25),
                                                  clipBehavior: Clip.antiAlias,
                                                  child: childCommenter.profilePicturePath.isEmpty
                                                      ? Image.asset('images/WorkServiceHub-DefaultProfilePic.png')
                                                      : Platform.isAndroid ? Image.file(File(childCommenter.profilePicturePath)) : Image.asset(childCommenter.profilePicturePath)
                                              ),
                                            ),
                                            title: Text(childCommenter.name),
                                            subtitle: Text(cc.text),
                                          );
                                        } else {
                                          return SizedBox(width: 30);
                                        }
                                      })
                                  ];
                                  return Padding(padding: .fromSTEB(50, 0, 0, 0), child: Column(children: childCommentsLoaded,));
                                }
                                return SizedBox(width: 30);
                              }
                              )
                            ],
                            )
                        );
                      })
              )
            ],
          )
      ),
    );
  }
}