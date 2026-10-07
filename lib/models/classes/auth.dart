import 'dart:convert';

class Auth {
  final int id;
  final String name;
  final String email;
  final String token;
  final String tokenType;
  final String type;
  final String description;
  final DateTime birthDate;
  final DateTime createdAt;


  //construtor da classe que recer cada um de seus atributos
  Auth({required this.id, required this.name, required this.email, required this.token, required this.tokenType,
    required this.type, required this.description, required this.birthDate, required this.createdAt});

  // Converte o objeto para um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
      'token_type': tokenType,
      'type': type,
      'description': description,
      'birth_date': birthDate.toIso8601String(),
      'created_at': createdAt.toIso8601String()
    };
  }

  // Cria um objeto a partir de un Map
  factory Auth.fromMap(Map<String, dynamic> map) {
    return Auth(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      token: map['token'] ?? '',
      type: map['type'] ?? '',
      tokenType: map['token_type'] ?? '',
      description: map['description'] ?? '',
      birthDate: DateTime.parse((map['birthDate'] ?? DateTime.now()).toString()),
      createdAt: DateTime.parse((map['created_at'] ?? DateTime.now()).toString()),
    );
  }

  // Facilita a conversão de uma lista de objetos para uma String JSON
  static String encode(Auth authData) => json.encode(authData.toMap().toString());

  // Facilita a conversão de uma String JSON para uma lista de objetos
  static Auth decode(String authsJson) => Auth.fromMap(json.decode(authsJson));
}