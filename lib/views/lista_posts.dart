import 'package:flutter/material.dart';

class ListaPosts extends StatefulWidget {
  const ListaPosts({super.key});

  @override
  State<ListaPosts> createState() => _ListaPostsState();
}

//classe altualizavel da tela
class _ListaPostsState extends State<ListaPosts> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WorkServiceHub',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'WorkServiceHub'),
    );
  }
}
class Template {
  final String title;
  final String author;
  final String description;
  bool isPressed;
  Template(this.title, this.author, this.description, this.isPressed);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final listaGerada = List.generate(8,
      (i) => Template(
        'Teste $i', 'Fulano da Silva', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
          ' In purus ligula, gravida quis nisi a, placerat finibus sapien. Aliquam fringilla semper nibh, id laoreet nisl dictum at. '
          'Proin justo ante, fermentum eget elit at, cursus aliquet odio. Donec pretium feugiat ante, quis egestas neque mattis sed. '
          'Pellentesque hendrerit justo id arcu vestibulum, nec consequat dolor sodales. Nunc condimentum eu nisi eget venenatis. Praesent sed eleifend ipsum.',
        false
      )

  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Expanded(
                child: ListView.builder(itemCount: listaGerada.length, itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                        title: Text(listaGerada[index].title),
                        subtitle: Text('Por ${listaGerada[index].author}'),
                        trailing: IconButton(onPressed: () {
                          setState(() {
                            listaGerada[index].isPressed = !listaGerada[index].isPressed;

                          });}, icon: listaGerada[index].isPressed
                            ? Icon(Icons.favorite, color: Colors.redAccent)
                            : Icon(Icons.favorite_border))
                    ),
                  );
                }
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Row(

        )
    );
  }
}