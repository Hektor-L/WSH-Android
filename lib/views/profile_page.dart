import 'dart:io';
import 'package:flutter/material.dart';
import 'package:workservicehub_project/models/classes/auth.dart';
import 'package:workservicehub_project/models/local_storage_service.dart';
import 'package:workservicehub_project/views/logout.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

//classe altualizavel da tela
class _ProfilePageState extends State<ProfilePage> {
  //método de inicialização da tela
  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Padding(padding: .all(24),
          child: FutureBuilder(future: LocalStorageService.loadAuth(), builder: (context, snapshot) {
            List<Widget> children;
            if(snapshot.hasData) {
              Auth auth = snapshot.data!;
              children = [
                Row(
                  spacing: 20,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                          borderRadius: .circular(50),
                          child: auth.profilePicturePath.isEmpty
                              ? Image.asset('images/WorkServiceHub-DefaultProfilePic.png')
                              : Platform.isAndroid ? Image.file(File(auth.profilePicturePath)) : Image.asset(auth.profilePicturePath)
                      )
                    ),
                    Text(auth.name, style: .new(fontSize: 30))
                  ],
                ),
                Text('Data de nascimento: ${auth.birthDate.day}/${auth.birthDate.month}/${auth.birthDate.year}', 
                    style: .new(fontSize: 10)),
                Text(auth.description),
                ElevatedButton(
                    onPressed: () {Navigator.pushReplacement(context, MaterialPageRoute<void>(builder: (context) => Logout()));},
                    style: .new(backgroundColor: .all(Colors.redAccent), foregroundColor: .all(Colors.white)), child: Text('Sair')
                )
              ];
            } else {
              children = [
                Center(
                  child: Column(
                    children: [
                      Text('Carregando Perfil. . .'),
                      SizedBox(
                          width: 200,
                          height: 20,
                          child: LinearProgressIndicator(backgroundColor: Colors.deepPurple, color: Colors.deepPurpleAccent,)
                      )
                    ],
                  )
                )
              ];
            }
            return Column(mainAxisAlignment: .center, spacing: 15, children: children);
          },)
        )
    );
  }
}