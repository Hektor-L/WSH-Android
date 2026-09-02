import 'package:flutter/material.dart';
import 'package:workservicehub_project/controllers/auth_controller.dart';
import 'package:workservicehub_project/views/login.dart';
import 'package:workservicehub_project/views/splash2.dart';

class Splash1 extends StatefulWidget {
  const Splash1({super.key});

  @override
  State<Splash1> createState() => _SplashState();
}

//classe altualizavel da tela
class _SplashState extends State<Splash1> {

  Future<bool> verifyLogin() async {
    if(await AuthController.verificaAutorizacaoOffline()) {
      ScaffoldMessenger.of(context).showSnackBar(.new(content: Text('Bem-vindo novamente ao WorkServiceHub!')));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Splash2())
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(.new(content: Text('Não há token de autorização, entre em sua conta.')));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login())
      );
    }
    return false;
  }
  //método de inicialização da tela
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () async {
      await verifyLogin();
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Carregando...',),
            SizedBox( height: 15, width: 140,
              child: LinearProgressIndicator(backgroundColor: Colors.deepPurple, color: Colors.deepPurpleAccent,),
            ),
          ],
        ),
      )
    );
  }
}