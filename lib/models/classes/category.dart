import 'dart:convert';

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] ?? 0,
      name: map['name'] ?? ''
    );
  }

  static String encode(List<Category> posts) => jsonEncode(
      posts.map<Map<String, dynamic>>((p) => p.toMap()).toList()
  );

  static List<Category> decode(String postsJson) =>
      (jsonDecode(postsJson) as List<dynamic>)
          .map<Category>((item) => Category.fromMap(item))
          .toList();
}