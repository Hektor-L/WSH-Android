import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workservicehub_project/controllers/user_list_controller.dart';
import 'package:workservicehub_project/models/classes/comment.dart';
import 'package:workservicehub_project/models/classes/post.dart';
import 'package:workservicehub_project/controllers/post_list_controller.dart';
import 'package:workservicehub_project/controllers/comment_list_controller.dart';
import 'package:workservicehub_project/models/classes/user.dart';

class ListaPosts extends StatefulWidget {
  const ListaPosts({super.key});
  @override
  State<ListaPosts> createState() => _ListaPostsState();
}

class _ListaPostsState extends State<ListaPosts> {
  late List<Post> _posts = [];
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
        _posters.add(await UserListController.findUser(p.posterId));
      }
      setState(() {
        _posts = data;
      });
    } catch(x) {
      print('Sem dados persistidos $x');
    }
  }

  void favorite(Post p) async {
    await PostListController.favorite(p);
    print('post de título ${p.title} favoritado!');
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Expanded(
                child: ListView.builder(itemCount: _posts.length, itemBuilder: (context, index) {
                  final post = _posts[index];
                  final poster = _posters[index];
                  return Card(
                    child: ListTile(
                        title: Text(post.title),
                        subtitle: Text('Publicado em ${post.createdAt.toString()} por ${poster.name}'),
                        trailing: IconButton(onPressed: () {
                          setState(() {
                            post.favorited = !post.favorited;
                          });
                          loadData();}, icon: post.favorited
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
            ],
          ),
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
      final data = await CommentListController.listComments(widget._post);
      setState(() {
        _comments = data;
      });
      for(Comment c in data){
        _commenters.add(await UserListController.findUser(c.commenterId));
      }
    } catch(x) {
      print('Sem dados persistidos $x');
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes da Publicação')),
      body: Padding(padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(widget._post.title, style: TextStyle(fontSize: 20)),
            Text('Publicado em ${widget._post.createdAt.toString()}, por ${widget._poster.name}', style: TextStyle(color: CupertinoColors.systemGrey)),
            Text(widget._post.description),
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
                  return ListTile(
                    leading:
                    SizedBox(height: 45, width: 45,
                      child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(25),
                          clipBehavior: Clip.antiAlias,
                          child: Image.asset('images/Default-ProfilePic.png')
                      ),
                    ),
                    title: Text(commenter.name),
                    subtitle: Text(comment.text),
                  );
                })
            )
          ],
        ),
      )
    );
  }
}