import 'dart:convert';

class Auth {
  final String name;
  final String email;
  final String password;
  final String authToken;


  //construtor da classe que recer cada um de seus atributos
  Auth({required this.name, required this.email,required this.password, required this.authToken});

  // Converte o objeto para um Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'authToken': authToken,
    };
  }

  // Cria um objeto a partir de un Map
  factory Auth.fromMap(Map<String, dynamic> map) {
    return Auth(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      authToken: map['authToken'] ?? '',
    );
  }

  // Facilita a conversão de uma lista de objetos para uma String JSON
  static String encode(List<Auth> auths) => json.encode(
    auths.map<Map<String, dynamic>>((p) => p.toMap()).toList(),
  );

  // Facilita a conversão de uma String JSON para uma lista de objetos
  static List<Auth> decode(String authsJson) =>
      (json.decode(authsJson) as List<dynamic>)
          .map<Auth>((item) => Auth.fromMap(item))
          .toList();
}