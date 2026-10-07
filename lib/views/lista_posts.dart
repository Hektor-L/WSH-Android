import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workservicehub_project/controllers/user_list_controller.dart';
import 'package:workservicehub_project/models/classes/comment.dart';
import 'package:workservicehub_project/models/classes/post.dart';
import 'package:workservicehub_project/controllers/post_list_controller.dart';
import 'package:workservicehub_project/controllers/comment_list_controller.dart';
import 'package:workservicehub_project/models/classes/user.dart';
import 'package:workservicehub_project/views/splash1.dart';

class DropdownOptions {
  final String label;
  final Icon icon;

  const DropdownOptions(this.label, this.icon);
}

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
      ScaffoldMessenger.of(context).showSnackBar(.new(content: Text('Sem dados persistidos $x')));
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
                    color: Colors.white,
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
const List<DropdownOptions> commentOptions = [DropdownOptions("Edit Comment", Icon(Icons.edit_outlined, color: Colors.blueAccent,)), DropdownOptions("Delete Comment", Icon(Icons.delete_outline, color: Colors.redAccent,))];

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
      ScaffoldMessenger.of(context).showSnackBar(.new(content: Text('Sem dados persistidos $x')));
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
                      return Card (
                          color: Colors.white,
                          child: ListTile(
                            leading:
                            SizedBox(height: 45, width: 45,
                              child: ClipRRect(
                                    borderRadius: BorderRadiusGeometry.circular(25),
                                    clipBehavior: Clip.antiAlias,
                                    child: SvgPicture.network('https://res.cloudinary.com/svdflnjt/image/upload/v1789745324/WorkServiceHub-DefaultProfilePic.svg')
                                ),
                              ),
                            title: Text(commenter.name),
                            subtitle: Text(comment.text),
                            trailing: commenter.id == loginData.id
                                ? DropdownButton<DropdownOptions>(
                                  items: commentOptions.map<DropdownMenuItem<DropdownOptions>>((DropdownOptions value) {
                                    return DropdownMenuItem(
                                        value: value,
                                        child: Row(
                                          children: [
                                            value.icon,
                                            Text(value.label),
                                          ]
                                        )
                                    );
                                  }).toList(),
                                  icon: Icon(Icons.more_vert),
                                  onChanged: (DropdownOptions? value) {
                                    if(value!.label == "Edit Comment"){
                                      log('Edit comment button activated.');
                                    } else if(value.label == "Delete Comment") {
                                      log('Delete comment button pressed.');
                                    }
                                  }
                                )
                                : SizedBox(height: 10, width: 10,)
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