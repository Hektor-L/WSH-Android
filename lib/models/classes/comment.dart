import 'dart:convert';

class Comment {
  final int id;
  final String text;
  final int commenterId;
  final int postId;
  final DateTime createdAt;

  Comment({required this.id, required this.text, required this.commenterId, required this.postId,
  required this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'commenter_id': commenterId,
      'post_id': postId,
      'created_at': createdAt.toIso8601String()
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
        id: map['id'] ?? 0,
        text: map['text'] ?? '',
        commenterId: map['commenter_id'] ?? 0,
        postId: map['post_id'] ?? 0,
        createdAt: DateTime.parse(map['created_at'].toString()),
    );
  }
  static String encode(List<Comment> posts) => json.encode(
    posts.map<Map<String, dynamic>>((p) => p.toMap()).toList(),
  );

  static List<Comment> decode(String commentsJson) =>
    (json.decode(commentsJson) as List<dynamic>)
        .map<Comment>((item) => Comment.fromMap(item))
        .toList();
}
