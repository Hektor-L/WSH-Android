import 'package:flutter/material.dart';
import 'package:workservicehub_project/controllers/auth_controller.dart';
import 'package:workservicehub_project/views/login.dart';

class Logout extends StatefulWidget{
  const Logout({super.key});
  @override
  State<Logout> createState() => _LogoutState();
}
class _LogoutState extends State<Logout> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () async {
      await AuthController.unloadAuth();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    });
  }
  @override
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