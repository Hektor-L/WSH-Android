import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workservicehub_project/models/classes/auth.dart';
import 'package:workservicehub_project/models/local_storage_service.dart';
import 'package:workservicehub_project/views/logoff.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

//classe altualizavel da tela
class _ProfilePageState extends State<ProfilePage> {
  late Auth _auth;
  @override
  void initState() {
    super.initState();
    getAuth();
  }
  void getAuth() async {
    try {
      final data = await LocalStorageService.loadAuth();
      setState(() {
        _auth = data!;
      });
    } catch(x) {
      print('Autenticação não encontrada, como você chegou aqui? Erro: $x');
    }
  }
  //método de inicialização da tela
  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Center(
          child: FutureBuilder(future: LocalStorageService.loadAuth(), builder: (context, snapshot) {
            List<Widget> children;
            if(snapshot.hasData) {
              children = [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                      borderRadius: .circular(50),
                      child: SvgPicture.network('https://res.cloudinary.com/svdflnjt/image/upload/v1789745324/WorkServiceHub-DefaultProfilePic.svg')
                  ),
                ),
                Container(
                    width: 300,
                    height: 200,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(45)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Nome: ${_auth.name}"),
                          Text("Email: ${_auth.email}"),
                          ElevatedButton(
                              onPressed: () {Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                      builder: (context) => Logoff()
                                  )
                              );
                              }, child: Text('Sair'))
                        ],
                      ),
                    )
                )
              ];
            } else {
              children = [
                Text('Loading Profile. . .'),
                SizedBox(
                  width: 200,
                  height: 20,
                  child: LinearProgressIndicator(backgroundColor: Colors.deepPurple, color: Colors.deepPurpleAccent,)
                )
              ];
            }
            return Column(mainAxisAlignment: .center, crossAxisAlignment: .center, children: children);
          },)
        )
    );
  }
}