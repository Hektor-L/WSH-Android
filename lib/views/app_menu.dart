import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'lista_posts.dart';
import 'lista_favorited.dart';
import 'profile_page.dart';

class AppMenu extends StatefulWidget {
  const AppMenu({super.key});

  @override
  State<AppMenu> createState() => _AppMenuState();
}

//classe altualizavel da tela
class _AppMenuState extends State<AppMenu> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WorkServiceHub',
      theme: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.blue, selectedItemColor: CupertinoColors.white,
            unselectedItemColor: CupertinoColors.systemPurple),
        appBarTheme: AppBarTheme(backgroundColor: Colors.blue),
      ),
      home: const MainPage(title: 'WorkServiceHub'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainState();
}

class _MainState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _pages[_currentIndex],
      bottomNavigationBar: _bottomNavBar()
    );
  }

  int _currentIndex = 0;
  final List<Widget> _pages = [
    ListaPosts(),
    ListaFavorited(),
    ProfilePage()
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }
  AppBar _appBar(){
    return AppBar(
      backgroundColor: AppBarTheme.of(context).backgroundColor,
      title: Row(
        children: [
          SizedBox(
            width: 300,
            height: 50,
            child: Image.asset('images/WorkServiceHub-Logo.png')
          ),
        ],
      )
    );
  }
  BottomNavigationBar _bottomNavBar(){
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index; // Atualiza o índice
        });
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: "Publicações"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: "Favoritos",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Perfil",
        ),
      ],
    );
  }
}