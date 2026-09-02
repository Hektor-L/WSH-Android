import 'package:flutter/material.dart';
import 'package:workservicehub_project/models/classes/category.dart';
import 'package:workservicehub_project/models/classes/comment.dart';
import 'package:workservicehub_project/models/classes/post.dart';
import 'package:workservicehub_project/models/classes/user.dart';
import 'package:workservicehub_project/models/local_storage_service.dart';
import 'package:workservicehub_project/views/app_menu.dart';

class Splash2 extends StatefulWidget{
  @override
  State<Splash2> createState() => _Splash2State();
}
class _Splash2State extends State<Splash2> {
  void preencheDados() {
    //salvando usuarios para teste.
    List<User> usuarios = User.decode("""[{"id": 1,"name": "João Silva","email": "joao.silva@ficmail.com","description": "Desenvolvedor de software focado em Flutter.","birthDate": "${DateTime(1995, 4, 15)}","type": "common"},
    {"id": 2, "name": "Luiza Lara", "email": "luiza.lara@ficmail.com", "description": "Olá!", "birthDate": "${DateTime(2009, 6, 21)}","type": "common"}]""");
    LocalStorageService.saveUsers(usuarios);
    //salvando categorias para teste.
    List<Category> categorias = Category.decode("[{\"id\": 1, \"name\": \"Teste\"}]");
    LocalStorageService.saveCategories(categorias);
    //salvando publicações para teste.
    List<Post> publicacoes = Post.decode("""[{
    "id": 1,
    "title": "Super Teste 123 - Testando o que não deve ser testado",
    "description": "Super Teste está em ação! O que ele vai fazer? Em uma de suas aventuras ele vem testar o que não deve ser testado... Um projeto inacabado de algo que pode salvar o mundo, mas trazer consequências terríveis!",
    "created_at": "${DateTime(2026, 8, 27, 8, 12, 56)}",
    "poster_id": 2,
    "category_id": 1,
    "favorited": false
    }]""");
    LocalStorageService.savePosts(publicacoes);
    //salvando comentários para teste.
    List<Comment> comentarios = Comment.decode("""[{
    "id": 1,
    "text": "Mamamia! O que vai ser dele?",
    "commenter_id": 1,
    "post_id": 1,
    "created_at": "${DateTime(2025, 1, 10)}"}]""");
    LocalStorageService.saveComments(comentarios);
  }
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      preencheDados();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppMenu()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            Text('Loading Forum. . .'),
            SizedBox(height: 15, width: 140,
              child: LinearProgressIndicator(backgroundColor: Colors.deepPurple, color: Colors.deepPurpleAccent,),
            ),
          ],
        ),
      ),
    );
  }
}