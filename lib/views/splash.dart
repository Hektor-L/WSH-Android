import 'package:flutter/material.dart';
import 'package:workservicehub_project/views/app_menu.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

//classe altualizavel da tela
class _SplashState extends State<Splash> {

  //método de inicialização da tela
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AppMenu()),
      );
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Carregando...',),
            SizedBox(
              height: 30,
            ),
            CircularProgressIndicator(),
          ],
        ),
      )
    );
  }
}