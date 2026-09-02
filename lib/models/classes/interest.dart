import 'dart:convert';
import 'package:workservicehub_project/models/classes/category.dart';
import 'package:workservicehub_project/models/classes/user.dart';

class Interest {
  final User interestedUser;
  final Category category;

  Interest({required this.interestedUser, required this.category});

  Map<String, dynamic> toMap() {
    return {
      'interestedUser_id': interestedUser,
      'category_id': category,
    };
  }

  factory Interest.fromMap(Map<String, dynamic> map) {
    return Interest(
      interestedUser: map['interestedUser_id'],
      category: map['category_id'],
    );
  }
  static String encode(List<Interest> interests) => json.encode(
    interests.map<Map<String, dynamic>>((i) => i.toMap()).toList(),
  );

  static List<Interest> decode(String interestsJson) =>
    (json.decode(interestsJson) as List<dynamic>)
        .map<Interest>((item) => Interest.fromMap(item))
        .toList();
}