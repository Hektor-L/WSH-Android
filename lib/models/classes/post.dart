import 'dart:convert';

class Post {
  final int id;
  final String title;
  final String description;
  final DateTime createdAt;
  //final User poster;
  final int posterId;
  //final Category category;
  final int categoryId;
  bool favorited;

  Post({required this.id, required this.title, required this.description,
    required this.createdAt, required this.posterId, required this.categoryId, required this.favorited});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'poster_id': posterId,
      //'category_id': categoryId.id,
      'category_id': categoryId,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      createdAt: DateTime.parse(map['created_at'].toString()),
      posterId: map['poster_id'] ?? '',
      //categoryId: map['category_id'] ?? LocalStorageService.convertIntoCategory(1),
      categoryId: map['category_id'] ?? '',
      favorited: map['favorited'] ?? false,
    );
  }
  static String encode(List<Post> posts) => json.encode(
    posts.map<Map<String, dynamic>>((p) => p.toMap()).toList(),
  );

  static List<Post> decode(String postsJson) =>
    (json.decode(postsJson) as List<dynamic>)
        .map<Post>((item) => Post.fromMap(item))
        .toList();
}