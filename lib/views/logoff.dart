import 'package:flutter/material.dart';
import 'package:workservicehub_project/controllers/auth_controller.dart';
import 'package:workservicehub_project/views/login.dart';

class Logoff extends StatefulWidget{
  const Logoff({super.key});

  @override
  State<Logoff> createState() => _LogoffState();
}
class _LogoffState extends State<Logoff> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      fazerLogoff();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    });
  }
  void fazerLogoff() async {
    await AuthController.unloadAuth();
  }
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.redAccent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Desconectando...',),
              SizedBox( height: 15, width: 140,
                child: LinearProgressIndicator(backgroundColor: Colors.deepPurple, color: Colors.deepPurpleAccent,),
              ),
            ],
          ),
        )
    );
  }
}