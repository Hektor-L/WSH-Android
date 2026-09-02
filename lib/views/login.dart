import 'package:flutter/material.dart';
import 'package:workservicehub_project/controllers/auth_controller.dart';
import 'package:workservicehub_project/models/classes/auth.dart';
import 'package:workservicehub_project/views/splash2.dart';

class Login extends StatefulWidget{
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _nameTEC = TextEditingController();
  final _emailTEC = TextEditingController();
  final _passwordTEC = TextEditingController();
  @override
  void dispose() {
    _nameTEC.dispose();
    _emailTEC.dispose();
    _passwordTEC.dispose();
    super.dispose();
  }
  void _sendForm() async {
    if(_formKey.currentState!.validate()) {
      Auth auth = Auth(name: _nameTEC.text, email: _emailTEC.text, password: _passwordTEC.text, authToken: '');
      if(await AuthController.verificaAutorizacaoOnline(auth)) {
        ScaffoldMessenger.of(context).showSnackBar(.new(content: Text('Autenticado com êxito! Bem-vindo, ${auth.name}!')));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Splash2()));
      } else {ScaffoldMessenger.of(context).showSnackBar(.new(content: Text('Usuário não foi autenticado, Tente novamente.')));}
    }
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            Text('Entrar', style: .new(fontSize: 30),),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    TextFormField(
                      controller: _nameTEC,
                      keyboardType: .emailAddress,
                      decoration: .new(labelText: 'Nome de Usuário', border: OutlineInputBorder()),
                      validator: (value) {
                        if(value == null || value.isEmpty) {
                          return 'Por favor, insira o seu nome de usuário.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    TextFormField(
                      controller: _emailTEC,
                      keyboardType: .visiblePassword,
                      decoration: .new(labelText: 'E-mail', border: OutlineInputBorder()),
                      validator: (value) {
                        if(value == null || value.isEmpty) {
                          return 'Por favor, insira seu e-mail.';
                        } else if(!value.contains('@', 1)) {
                          return 'Formato de e-mail inválido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: _passwordTEC,
                      keyboardType: .emailAddress,
                      decoration: .new(labelText: 'Senha', border: OutlineInputBorder()),
                      validator: (value) {
                        if(value == null || value.isEmpty) {
                          return 'Por favor, insira sua senha.';
                        } else if(value.length < 8) {
                          return 'A senha deve ter no mínimo 8 caracteres.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(onPressed: _sendForm,
                      style: .new(backgroundColor: .all(Colors.deepPurpleAccent)),
                      child: const Text('Log In'),
                    )
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}