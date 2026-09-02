import 'dart:convert';

class User {
  final int id;
  final String name;
  final String email;
  final String description;
  final DateTime birthDate;
  final String type;

  User({required this.id, required this.name, required this.email, required this.description,
    required this.birthDate, required this.type});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'description': description,
      'birthDate': birthDate.toIso8601String(),
      'type': type,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'] ?? 0,
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        description: map['description'] ?? '',
        birthDate: DateTime.parse(map['birthDate'].toString()),
        type: map['type'] ?? 'common',
    );
  }
  static String encode(List<User> posts) => json.encode(
    posts.map<Map<String, dynamic>>((p) => p.toMap()).toList(),
  );

  static List<User> decode(String usersJson) =>
      (json.decode(usersJson) as List<dynamic>)
          .map<User>((item) => User.fromMap(item))
          .toList();
}